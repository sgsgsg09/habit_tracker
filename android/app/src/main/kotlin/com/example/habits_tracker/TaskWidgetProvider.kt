package com.example.habits_tracker

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews

class TaskWidgetProvider : AppWidgetProvider() {
    private val TAG = "TaskWidgetProvider"

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        Log.d(TAG, "onUpdate called with appWidgetIds: ${appWidgetIds.joinToString()}")

        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }

    private fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        Log.d(TAG, "updateWidget called for widget ID: $appWidgetId")

        val views = RemoteViews(context.packageName, R.layout.widget_layout)

        // ListView, GridView 등과 같은 RemoteViewsAdapter를 연결하기 위해 Service Intent 생성
        val serviceIntent = Intent(context, TaskWidgetService::class.java)
        views.setRemoteAdapter(R.id.task_list_view, serviceIntent)
        views.setEmptyView(R.id.task_list_view, R.id.empty_view)

        // 리스트 아이템을 클릭했을 때, MainActivity로 이동하도록 설정
        val clickIntent = Intent(context, MainActivity::class.java)
        val clickPendingIntent = PendingIntent.getActivity(
            context, 0, clickIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        views.setPendingIntentTemplate(R.id.task_list_view, clickPendingIntent)

        // 실제 위젯 업데이트
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        super.onReceive(context, intent)

        if (intent?.action == "com.example.habits_tracker.UPDATE_WIDGET") {
            // Flutter에서 invokeMethod("updateWidget") 실행 시 onReceive를 통해 이 action을 받을 수도 있음
            Log.d(TAG, "Received custom action to update widget")

            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context!!, TaskWidgetProvider::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

            // updateWidget() 호출로 각각의 위젯 갱신
            for (appWidgetId in appWidgetIds) {
                updateWidget(context, appWidgetManager, appWidgetId)
            }

            // ListView가 즉각적으로 갱신되도록 알림
            appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetIds, R.id.task_list_view)
        }
    }
}