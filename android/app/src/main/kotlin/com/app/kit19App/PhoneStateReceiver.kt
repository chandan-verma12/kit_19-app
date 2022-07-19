package com.app.kit19App

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.widget.Toast
import java.lang.Exception

class PhoneStateReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        try {
            println("Receiver start")
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            val incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
            if (state == TelephonyManager.EXTRA_STATE_RINGING) {
                Toast.makeText(context, "Incoming Call State", Toast.LENGTH_SHORT).show()
                Toast.makeText(
                    context,
                    "Ringing State Number is -$incomingNumber",
                    Toast.LENGTH_SHORT
                ).show()
            }
            if (state == TelephonyManager.EXTRA_STATE_OFFHOOK) {
                Toast.makeText(context, "Call Received State", Toast.LENGTH_SHORT).show()
            }
            if (state == TelephonyManager.EXTRA_STATE_IDLE) {
                Toast.makeText(context, "Call Idle State", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}