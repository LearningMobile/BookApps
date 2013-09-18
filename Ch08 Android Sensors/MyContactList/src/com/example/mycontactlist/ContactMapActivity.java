package com.example.mycontactlist;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.SupportMapFragment;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Point;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.location.Address;
import android.location.Geocoder;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.view.Display;
import android.view.Menu;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

public class ContactMapActivity extends FragmentActivity {
	
	GoogleMap googleMap;
    SensorManager sensorManager;
    Sensor accelerometer;
    Sensor magnetometer;
    TextView textDirection;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_contact_map);
		
		initLocationButton();
		initMapTypeButton();
		initListButton();
		initMapButton();
		initSettingsButton();

		sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
		accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
		magnetometer = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);

		if (accelerometer != null && magnetometer != null) {
		    sensorManager.registerListener(mySensorEventListener, accelerometer,SensorManager.SENSOR_DELAY_FASTEST);
		    sensorManager.registerListener(mySensorEventListener, magnetometer,SensorManager. SENSOR_DELAY_FASTEST);
		} else {
		    Toast.makeText(this, "Sensors not found",Toast.LENGTH_LONG).show();
		}
		
	    textDirection = (TextView) findViewById(R.id.textHeading);
		    
		googleMap = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map)).getMap();
		googleMap.setMapType(GoogleMap.MAP_TYPE_NORMAL);

		ArrayList<Contact> contacts = new ArrayList<Contact>();
		Contact currentContact = null;
		Bundle extras = getIntent().getExtras();
		if(extras !=null){
		    ContactDataSource ds = new ContactDataSource(ContactMapActivity.this);
		    ds.open();
		    currentContact = ds.getSpecificContact(extras.getInt("contactid"));
		    ds.close();
		}
		else {
		    ContactDataSource ds = new ContactDataSource(ContactMapActivity.this);
		    ds.open();
		    contacts = ds.getContacts("contactname", "ASC");
		    ds.close();
		}

		int measuredWidth = 0;  
		int measuredHeight = 0;  
		Point size = new Point();
		WindowManager w = getWindowManager();

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB){
		    w.getDefaultDisplay().getSize(size);
		    measuredWidth = size.x;
		    measuredHeight = size.y; 
		}else {
		    Display d = w.getDefaultDisplay(); 
		    measuredWidth = d.getWidth(); 
		    measuredHeight = d.getHeight()-180; 
		}

		if (contacts.size()>0) {
		    LatLngBounds.Builder builder = new LatLngBounds.Builder();
		    for (int i=0; i<contacts.size(); i++) {
		        currentContact = contacts.get(i);
						
		        Geocoder geo = new Geocoder(this);
		        List<Address> addresses = null;
						
		        String address = currentContact.getStreetAddress() + ", " +
		                            currentContact.getCity() + ", " +
		                            currentContact.getState() + " " + 
		                            currentContact.getZipCode();
			
		        try {
		            addresses = geo.getFromLocationName(address, 1);
		        } 
		        catch (IOException e) {
		            e.printStackTrace();
		        }
		        LatLng point = new LatLng(addresses.get(0).getLatitude(),addresses.get(0).getLongitude());
		        builder.include(point);
			
		        googleMap.addMarker(new MarkerOptions().position(point).title(currentContact.getContactName()).snippet(address));
		    }
		    googleMap.animateCamera(CameraUpdateFactory.newLatLngBounds(builder.build(),measuredWidth, measuredHeight, 100));
		}
		else {
		    if (currentContact != null) {
		        Geocoder geo = new Geocoder(this);
		        List<Address> addresses = null;
						
		        String address = currentContact.getStreetAddress() + ", " +
		                            currentContact.getCity() + ", " +
		                            currentContact.getState() + " " + 
		                            currentContact.getZipCode();
			
		        try {
		            addresses = geo.getFromLocationName(address, 1);
		        } 
		        catch (IOException e) {
		            e.printStackTrace();
		        }
		        LatLng point = new LatLng(addresses.get(0).getLatitude(),addresses.get(0).getLongitude());
			
		        googleMap.addMarker(new MarkerOptions().position(point).title(currentContact.getContactName()).snippet(address));
		        googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(point, 16));
		    }	
		        else {
		            AlertDialog alertDialog = new AlertDialog.Builder(ContactMapActivity.this).create();
		            alertDialog.setTitle("No Data");
		            alertDialog.setMessage("No data is available for the mapping function.");
		            alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, "OK", new DialogInterface.OnClickListener() {
		            public void onClick(DialogInterface dialog, int which) {
		            finish();
		        } });
		        alertDialog.show();
		    }
		}

	}

	private void initLocationButton() {
	    final Button locationbtn = (Button) findViewById(R.id.buttonShowMe);
	    locationbtn.setOnClickListener(new View.OnClickListener() {
	        public void onClick(View v) {
	            String currentSetting = locationbtn.getText().toString();
	            if (currentSetting.equalsIgnoreCase("Location On")) {
	                locationbtn.setText("Location Off");
	                googleMap.setMyLocationEnabled(true);
	            }
	            else {
	                locationbtn.setText("Location On");
	                googleMap.setMyLocationEnabled(false);
	            }   
	         }
	    }); 
	}  
	    
	private void initMapTypeButton() {
	    final Button satelitebtn = (Button) findViewById(R.id.buttonMapType);
	    satelitebtn.setOnClickListener(new View.OnClickListener() {
	        public void onClick(View v) {
	            String currentSetting = satelitebtn.getText().toString();
	            if (currentSetting.equalsIgnoreCase("Satellite View")) {
	                googleMap.setMapType(GoogleMap.MAP_TYPE_SATELLITE);
	                satelitebtn.setText("Normal View");
	            }
	            else {
	                googleMap.setMapType(GoogleMap.MAP_TYPE_NORMAL);
	                satelitebtn.setText("Satellite View");
	            }
	        }
	    }); 
	}  
   
    @Override
    public boolean onCreateOptionsMenu(Menu menu){


    	return true;
    } 

    public void onPause() {
    	   super.onPause();
    	   finish();
    	}
    	    
    	@Override
    	public void onResume() {
    	    super.onResume();
    	    final String TAG_ERROR_DIALOG_FRAGMENT="errorDialog";

    	    int status=GooglePlayServicesUtil.isGooglePlayServicesAvailable(this);

    	    if (status == ConnectionResult.SUCCESS) {
    		                  //no problems just work
    	    }
    	    else if (GooglePlayServicesUtil.isUserRecoverableError(status)) {
    	        ErrorDialogFragment.newInstance(status).show(getSupportFragmentManager(),
    	                                            TAG_ERROR_DIALOG_FRAGMENT);
    	    }
    	    else {
    	        Toast.makeText(this, "Google Maps V2 is not available!", 
    	                             Toast.LENGTH_LONG).show();
    	        finish();
    	    }		
    	}
    		
    	public static class ErrorDialogFragment extends DialogFragment {
    	    static final String ARG_STATUS="status";

    	    static ErrorDialogFragment newInstance(int status) {
    	        Bundle args=new Bundle();
    	        args.putInt(ARG_STATUS, status);
    	        ErrorDialogFragment result=new ErrorDialogFragment();
    	        result.setArguments(args);
    	        return(result);
    	    }

    	    @Override
    	    public Dialog onCreateDialog(Bundle savedInstanceState) {
    	        Bundle args=getArguments();
    	        return GooglePlayServicesUtil.getErrorDialog(args.getInt(ARG_STATUS),
    	                                                            getActivity(), 0);
    	    }

    	    @Override
    	    public void onDismiss(DialogInterface dlg) {
    	        if (getActivity() != null) {
    	            getActivity().finish();
    	        }
    	    }
    	}
    	private void initListButton() {
            ImageButton list = (ImageButton) findViewById(R.id.imageButtonList);
            list.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
        			Intent intent = new Intent(ContactMapActivity.this, ContactListActivity.class);
        			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        			startActivity(intent);
                }
            });
    	}
    	
    	private void initMapButton() {
            ImageButton list = (ImageButton) findViewById(R.id.imageButtonMap);
            list.setEnabled(false);
    	}
    	
    	private void initSettingsButton() {
            ImageButton list = (ImageButton) findViewById(R.id.imageButtonSettings);
            list.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
        			Intent intent = new Intent(ContactMapActivity.this, ContactSettingsActivity.class);
        			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        			startActivity(intent);
                }
            });
    	}
    	
    	private SensorEventListener mySensorEventListener = new SensorEventListener() {

    	    public void onAccuracyChanged(Sensor sensor, int accuracy) {  }
    	  
    	    float[] accelerometerValues;
    	    float[] magneticValues;
    	  
    	    public void onSensorChanged(SensorEvent event) {
    	    if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER)
    	        accelerometerValues = event.values;
    	    if (event.sensor.getType() == Sensor.TYPE_MAGNETIC_FIELD)
    	        magneticValues = event.values;
    	    if (accelerometerValues!= null && magneticValues!= null) {
    	        float R[] = new float[9];
    	        float I[] = new float[9];
    	        boolean success = SensorManager.getRotationMatrix(R, I,accelerometerValues, magneticValues);
    	        if (success) {
    	            float orientation[] = new float[3];
    	            SensorManager.getOrientation(R, orientation);
    	        
    	            float azimut = (float) Math.toDegrees(orientation[0]);
    	            if (azimut < 0.0f) { azimut+=360.0f;}
    	            String direction;
    	            if (azimut >= 315 || azimut < 45) { direction = "N"; }
    	            else if (azimut >= 225 && azimut < 315) { direction = "W"; }
    	            else if (azimut >= 135 && azimut < 225) { direction = "S"; }
    	            else { direction = "E"; }
    	            textDirection.setText(direction);	        
    	        }
    	       }
    	    }
    	};

}
