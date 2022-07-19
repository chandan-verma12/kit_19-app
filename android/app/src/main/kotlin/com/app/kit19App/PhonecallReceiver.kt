package com.app.kit19App

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import java.lang.Exception
import java.util.*

abstract class PhonecallReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        try {
            if (intent.action == "android.intent.action.NEW_OUTGOING_CALL") {
                savedNumber = intent.extras!!.getString("android.intent.extra.PHONE_NUMBER")
            } else {
                val stateStr = intent.extras!!.getString(TelephonyManager.EXTRA_STATE)
                val number = intent.extras!!.getString(TelephonyManager.EXTRA_INCOMING_NUMBER)
                var state = 0
                if (stateStr == TelephonyManager.EXTRA_STATE_IDLE) {
                    state = TelephonyManager.CALL_STATE_IDLE
                } else if (stateStr == TelephonyManager.EXTRA_STATE_OFFHOOK) {
                    state = TelephonyManager.CALL_STATE_OFFHOOK
                } else if (stateStr == TelephonyManager.EXTRA_STATE_RINGING) {
                    state = TelephonyManager.CALL_STATE_RINGING
                }
                onCallStateChanged(context, state, number)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    //Derived classes should override these to respond to specific events of interest
    protected open fun onIncomingCallStarted(ctx: Context?, number: String?, start: Date?) {}
    protected open fun onIncomingCallEnded(
        ctx: Context?,
        number: String?,
        start: Date?,
        end: Date?
    ) {
    }

    fun onCallStateChanged(context: Context?, state: Int, number: String?) {
        if (lastState == state) {
            //No change, debounce extras
            return
        }
        when (state) {
            TelephonyManager.CALL_STATE_RINGING -> {
                isIncoming = true
                callStartTime = Date()
                savedNumber = number
                onIncomingCallStarted(context, number, callStartTime)
            }
            TelephonyManager.CALL_STATE_OFFHOOK -> {
                if (isIncoming) {
                    onIncomingCallEnded(context, savedNumber, callStartTime, Date())
                }
                if (isIncoming) {
                    onIncomingCallEnded(context, savedNumber, callStartTime, Date())
                }
            }
            TelephonyManager.CALL_STATE_IDLE -> if (isIncoming) {
                onIncomingCallEnded(context, savedNumber, callStartTime, Date())
            }
        }
        lastState = state
    }

    companion object {
        private var lastState = TelephonyManager.CALL_STATE_IDLE
        private var callStartTime: Date? = null
        private var isIncoming = false
        private var savedNumber: String? = null
    }
}