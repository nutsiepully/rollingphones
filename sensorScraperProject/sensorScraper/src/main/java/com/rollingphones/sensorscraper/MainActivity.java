package com.rollingphones.sensorscraper;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {

    private SensorManager mSensorManager;

    private Sensor mTotalAccelSensor;
    private Sensor mGravitySensor;
    private Sensor mLinearAccelSensor;
    private Sensor mGyroSensor;

    private MainActivity.SensorListener mTotalAccListener;
    private MainActivity.SensorListener mGravityListener;
    private MainActivity.SensorListener mLinearAccelListener;
    private MainActivity.SensorListener mGyroListener;

    private List<Reading> totalAccelerationReadings;
    private List<Reading> gravityReadings;
    private List<Reading> linearAccelerationReadings;
    private List<Reading> gyroReadings;

    private Button mWriteSensorDataButton;

    class Reading {
        float x;
        float y;
        float z;

        public Reading(float[] values) {
            this.x = values[0];
            this.y = values[1];
            this.z = values[2];
        }
    }

    /*
     * For a sampling rate of 50Hz, we take 50 readings per second. So to
     * store data for 10 minutes, we need to store
     *
     *  10 * 60 * 50 = 30k readings.
     *
     * We store x,y,z for totalAccel, gravity, linearAccel, gyro. So we need
     *
     *  4 * 3 * 30k * 8 / (10 ^ 6) = 2.88 MB
     *
     *  So let's just store it in memory shall we :-)
     */

    /*
     * Sampling Rate : 50Hz
     * 1 / 50 * ( 10 ^ 6 ) = 20k microseconds
     */
    private int SAMPLING_RATE = 20000;

    /*
     * Number of readings to include in a window.
     */
    private int WINDOW_SIZE = 128;

    /*
     * Number of readings from previous window to
     * incorporate into current window.
     *  In percentage (0-100)
     */
    private int OVERLAP = 50;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mWriteSensorDataButton = (Button)findViewById(R.id.writeSensorDataButton);

        this.totalAccelerationReadings = new ArrayList<Reading>();
        this.gravityReadings = new ArrayList<Reading>();
        this.linearAccelerationReadings = new ArrayList<Reading>();
        this.gyroReadings = new ArrayList<Reading>();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    class SensorListener implements SensorEventListener {
        private final List<Reading> readingList;

        public SensorListener(List<Reading> readingList) {
            this.readingList = readingList;
        }

        @Override
        public void onSensorChanged(SensorEvent event) {
            this.readingList.add(new Reading(event.values));
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
    }

    private void startScraping() {
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

        mTotalAccelSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        mTotalAccListener = new SensorListener(totalAccelerationReadings);
        mSensorManager.registerListener(mTotalAccListener, mTotalAccelSensor, SAMPLING_RATE);

        mGravitySensor = mSensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY);
        mGravityListener = new SensorListener(gravityReadings);
        mSensorManager.registerListener(mGravityListener, mGravitySensor, SAMPLING_RATE);

        mLinearAccelSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION);
        mLinearAccelListener = new SensorListener(linearAccelerationReadings);
        mSensorManager.registerListener(mLinearAccelListener, mLinearAccelSensor, SAMPLING_RATE);

        mGyroSensor = mSensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE);
        mGyroListener = new SensorListener(gyroReadings);
        mSensorManager.registerListener(mGyroListener, mGyroSensor, SAMPLING_RATE);
    }

    public void startStopClick(View view) {
        Button startStopButton = (Button) view;

        if (startStopButton.getText().toString().equalsIgnoreCase("start")) {
            startStopButton.setText("STOP");
            startScraping();
            mWriteSensorDataButton.setEnabled(false);
        } else {
            startStopButton.setText("START");
            mWriteSensorDataButton.setEnabled(true);
            stopScraping();
        }
    }

    private void stopScraping() {
        mSensorManager.unregisterListener(mTotalAccListener);
        mSensorManager.unregisterListener(mGravityListener);
        mSensorManager.unregisterListener(mLinearAccelListener);
        mSensorManager.unregisterListener(mGyroListener);
    }
}
