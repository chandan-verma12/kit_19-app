package com.app.kit19App

import android.content.Context
import android.widget.Toast
import java.util.*

class CallReceiver : PhonecallReceiver() {
    private var context: Context? = null
    override fun onIncomingCallStarted(ctx: Context?, number: String?, start: Date?) {
        Toast.makeText(ctx, "Kushal Incoming Call$number", Toast.LENGTH_LONG).show()
        context = ctx
//        val intent = Intent(context, MyCustomDialog::class.java)
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//        intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
//        intent.putExtra("phone_no", number)
//        Handler().postDelayed({ context!!.startActivity(intent) }, 2000)

//        MyCus/*tomDialog dialog   =   new MyCustomDialog(context);
//        dialog.*/show();
    }

    override fun onIncomingCallEnded(ctx: Context?, number: String?, start: Date?, end: Date?) {
        Toast.makeText(ctx, "Bye Bye$number", Toast.LENGTH_LONG).show()
    }
}