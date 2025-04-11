package com.example.habits_tracker

import android.content.Context
import android.content.SharedPreferences
import android.graphics.Color
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import org.json.JSONArray
import org.json.JSONException

/**
 * 데이터를 JSON 형태로 파싱하고, RemoteViews로 연결해주는 Factory
 */
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

        // colorHex가 있으면 배경 혹은 텍스트 색상 등에 적용 가능
        // 예: 텍스트 색상을 변경
        //     views.setTextColor(R.id.task_text, Color.parseColor(item.colorHex))

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
 
        // Flutter에서 prefs.setString('tasks', jsonString)을 하면
        // 안드로이드 내부적으로는 "flutter.tasks"로 저장될 가능성이 큼.
        // (버전에 따라 직접 "tasks"로 저장될 수도 있으니 확인 필요)
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

                tempList.add(
                    HabitItem(
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
    val title: String,
    val targetCount: Int,
    val currentCount: Int,
    val colorHex: String
)