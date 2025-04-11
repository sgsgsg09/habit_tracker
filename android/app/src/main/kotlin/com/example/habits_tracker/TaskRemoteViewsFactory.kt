package com.example.habits_tracker

import android.app.PendingIntent
import android.content.Intent
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import org.json.JSONArray
import org.json.JSONException

class TaskRemoteViewsFactory(private val context: Context) : RemoteViewsService.RemoteViewsFactory {
    private val TAG = "TaskRemoteViewsFactory"

    // Flutter에서 넘어온 습관 정보를 담을 목록
    private var habitList: List<HabitItem> = emptyList()

    override fun onCreate() {
        // 최초 생성 시점
        Log.d(TAG, "onCreate")
        loadTasks()
    }

    override fun onDataSetChanged() {
        // 위젯에서 notifyAppWidgetViewDataChanged 호출 시, 새로고침될 때마다 불리는 메서드
        Log.d(TAG, "onDataSetChanged called")
        loadTasks()
    }

    override fun onDestroy() {
        // 필요 시 정리 작업
    }

    override fun getCount(): Int = habitList.size

    override fun getViewAt(position: Int): RemoteViews {
        // 각 항목(행)을 구성하는 부분
        val item = habitList[position]

        // task_item.xml 레이아웃 inflate
        val views = RemoteViews(context.packageName, R.layout.task_item)
        
        // 예) "물 마시기 (3 / 10)" 형식으로 표시
        val displayText = "${item.title} (${item.currentCount} / ${item.targetCount})"
        views.setTextViewText(R.id.task_text, displayText)

        // 색상 적용
        try {
            val color = Color.parseColor(item.colorHex)
            views.setInt(R.id.item_container, "setBackgroundColor", color)
            
            // 배경색 명암에 따른 텍스트 색상 조정
            val brightness = (Color.red(color) * 0.299 + 
                           Color.green(color) * 0.587 + 
                           Color.blue(color) * 0.114)
            if (brightness < 160) {
                views.setTextColor(R.id.task_text, Color.WHITE)
            } else {
                views.setTextColor(R.id.task_text, Color.BLACK)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error parsing color: ${item.colorHex}", e)
            // 에러 시 기본 색상 사용
        }
        
     // 중요 변경: 목표에 도달하지 않은 항목만 클릭 활성화
    if (item.currentCount < item.targetCount) {
        // 클릭 시 카운트 증가를 위한 fillInIntent 설정
        val fillInIntent = Intent()
        fillInIntent.putExtra("HABIT_TITLE", item.title)
        
        // 전체 항목을 클릭 가능하게 설정
        views.setOnClickFillInIntent(R.id.item_container, fillInIntent)
    } 
    return views
}

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long = position.toLong()

    override fun hasStableIds(): Boolean = true

    /**
     * Flutter에서 SharedPreferences에 저장한 JSON Array를 파싱해서 habitList를 갱신
     */
    private fun loadTasks() {
        val prefs: SharedPreferences = context.getSharedPreferences(
            "FlutterSharedPreferences",
            Context.MODE_PRIVATE
        )
 
        val tasksString = prefs.getString("flutter.tasks", "") ?: ""
        Log.d(TAG, "SharedPreferences data: $tasksString")
        
        if (tasksString.isEmpty()) {
            habitList = emptyList()
            return
        }

        try {
            val jsonArray = JSONArray(tasksString)
            val tempList = mutableListOf<HabitItem>()

            for (i in 0 until jsonArray.length()) {
                val jsonObj = jsonArray.getJSONObject(i)
                val title = jsonObj.optString("title", "")
                val targetCount = jsonObj.optInt("targetCount", 0)
                val currentCount = jsonObj.optInt("currentCount", 0)
                val colorHex = jsonObj.optString("colorHex", "#FFFFFF")
                val id = jsonObj.optString("id", "")

                tempList.add(
                    HabitItem(
                        id = id,
                        title = title,
                        targetCount = targetCount,
                        currentCount = currentCount,
                        colorHex = colorHex
                    )
                )
            }
            habitList = tempList
        } catch (e: JSONException) {
            e.printStackTrace()
            habitList = emptyList()
        }
    }
}

/**
 * 위젯에서 쓸 간단한 Data Class
 */
data class HabitItem(
    val id: String,
    val title: String,
    val targetCount: Int,
    val currentCount: Int,
    val colorHex: String
)