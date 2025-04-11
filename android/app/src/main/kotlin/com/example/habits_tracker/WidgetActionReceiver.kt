// android/app/src/main/kotlin/com/example/habits_tracker/WidgetActionReceiver.kt
package com.example.habits_tracker

import android.app.ActivityManager
import android.appwidget.AppWidgetManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray

class WidgetActionReceiver : BroadcastReceiver() {
    private val TAG = "WidgetActionReceiver"
    private val WIDGET_ACTION_CHANNEL = "com.example.habits_tracker/widget_action"

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "com.example.habits_tracker.INCREMENT_HABIT") {
            val habitTitle = intent.getStringExtra("HABIT_TITLE") ?: return
            Log.d(TAG, "Received increment action for: $habitTitle")
            
            // 앱이 실행 중인지 확인
            val isAppRunning = isAppRunning(context)
            
            if (isAppRunning) {
                // 앱이 실행 중이면 MethodChannel을 통해 Flutter에 알림
                callFlutterMethod(context, habitTitle)
            } else {
                // 앱이 실행 중이 아니면 직접 처리
                updateHabitDirectly(context, habitTitle)
            }
        }
    }
    

    
    // Flutter 메서드 호출 (앱이 실행 중일 때)
    private fun callFlutterMethod(context: Context, habitTitle: String) {
        try {
      // 메인 액티비티를 통해 Flutter 메서드 호출
        val intent = Intent(context, MainActivity::class.java).apply {
            action = "com.example.habits_tracker.CALL_FLUTTER_METHOD"
            putExtra("METHOD", "incrementHabit")
            putExtra("HABIT_TITLE", habitTitle)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        context.startActivity(intent)
        
        // 선택적: 앱이 이미 실행 중인 경우에만 Method Channel을 통해 통신
        // 이 방식은 앱을 전면에 띄우지 않음
        } catch (e: Exception) {
            Log.e(TAG, "Error calling Flutter method", e)
            // 실패 시 직접 처리
            updateHabitDirectly(context, habitTitle)
        }
    }
    
    // 직접 SharedPreferences 데이터 업데이트 (앱이 실행 중이 아닐 때)
    private fun updateHabitDirectly(context: Context, habitTitle: String) {
        try {
            // Flutter 앱의 SharedPreferences 데이터 읽기
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val tasksString = prefs.getString("flutter.tasks", "")
            
            if (tasksString.isNullOrEmpty()) {
                Log.w(TAG, "No tasks data found in SharedPreferences")
                return
            }
            
            // JSON 파싱 및 업데이트
            val jsonArray = JSONArray(tasksString)
            var updated = false
            
            for (i in 0 until jsonArray.length()) {
                val habit = jsonArray.getJSONObject(i)
                if (habit.getString("title") == habitTitle) {
                    val currentCount = habit.getInt("currentCount")
                    val targetCount = habit.getInt("targetCount")
                    
                    // 목표를 초과하지 않는 경우에만 증가
                    if (currentCount < targetCount) {
                        habit.put("currentCount", currentCount + 1)
                        updated = true
                        Log.d(TAG, "Incremented habit count: $habitTitle ($currentCount -> ${currentCount + 1})")
                    } else {
                        Log.d(TAG, "Habit already reached target count: $habitTitle")
                    }
                    break
                }
            }
            
            if (updated) {
                // 업데이트된 데이터 저장
                prefs.edit().putString("flutter.tasks", jsonArray.toString()).apply()
                
                // 위젯 UI 갱신
                updateWidgetUI(context)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error updating habit directly", e)
        }
    }
    
    // 위젯 UI 갱신
    private fun updateWidgetUI(context: Context) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context, TaskWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        
        // 위젯 데이터 갱신
        appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.task_list_view)
        
        // 위젯 전체 갱신 브로드캐스트
        val updateIntent = Intent(context, TaskWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
        }
        context.sendBroadcast(updateIntent)
        
        Log.d(TAG, "Widget UI updated")
    }
    // WidgetActionReceiver.kt 업데이트
private fun isAppRunning(context: Context): Boolean {
    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
    val processes = activityManager.runningAppProcesses ?: return false
    
    val packageName = context.packageName
    for (processInfo in processes) {
        if (processInfo.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND
            && processInfo.processName == packageName) {
            return true
        }
    }
    return false
}
}