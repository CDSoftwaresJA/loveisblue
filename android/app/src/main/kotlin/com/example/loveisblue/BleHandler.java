package com.example.loveisblue;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;


import java.util.HashMap;

import io.flutter.plugin.common.EventChannel;

public  class BleHandler implements EventChannel.StreamHandler {

    private BluetoothAdapter mBluetoothAdapter= BluetoothAdapter.getDefaultAdapter();;
    private EventChannel.EventSink eventSink;

    @Override
    public void onListen(Object o, final EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
        mBluetoothAdapter.startLeScan(mLeScanCallback);
    }

    @Override
    public void onCancel(Object o) {
        eventSink.endOfStream();
        mBluetoothAdapter.stopLeScan(mLeScanCallback
        );
    }

    private BluetoothAdapter.LeScanCallback mLeScanCallback = new
            BluetoothAdapter.LeScanCallback() {
                @Override
                public void onLeScan(final BluetoothDevice device, final int rssi,
                                     final byte[] scanRecord) {
                            String uuid = IntToHex2(scanRecord[6] & 0xff) + IntToHex2(scanRecord[7] & 0xff) + IntToHex2(scanRecord[8] & 0xff) + IntToHex2(scanRecord[9] & 0xff)
                                    + "-" + IntToHex2(scanRecord[10] & 0xff) + IntToHex2(scanRecord[11] & 0xff)
                                    + "-" + IntToHex2(scanRecord[12] & 0xff) + IntToHex2(scanRecord[13] & 0xff)
                                    + "-" + IntToHex2(scanRecord[14] & 0xff) + IntToHex2(scanRecord[15] & 0xff)
                                    + "-" + IntToHex2(scanRecord[16] & 0xff) + IntToHex2(scanRecord[17] & 0xff)
                                    + IntToHex2(scanRecord[18] & 0xff) + IntToHex2(scanRecord[19] & 0xff)
                                    + IntToHex2(scanRecord[20] & 0xff) + IntToHex2(scanRecord[21] & 0xff);
                            HashMap<String,Object> HashMap=new HashMap<String,Object>();
                            HashMap.put("uuid",uuid);
                            HashMap.put("rssi",rssi);
                            eventSink.success(HashMap);
                }
            };

    public String IntToHex2(int i) {
        char hex_2[] = {Character.forDigit((i >> 4) & 0x0f, 16), Character.forDigit(i & 0x0f, 16)};
        String hex_2_str = new String(hex_2);
        return hex_2_str.toUpperCase();
    }


}

