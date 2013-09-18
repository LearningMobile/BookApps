package com.example.mycontactlist;

import java.io.IOException;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class ContactMapActivity extends Activity {
	
	LocationManager locationManager;
    LocationListener gpsListener;
    LocationListener networkListener;
    Location currentBestLocation;

	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contact_map);
        
        initGetLocationButton();

    }

    
    @Override
    public boolean onCreateOptionsMenu(Menu menu){


    	return true;
    } 
    
    private void initGetLocationButton() {
    	Button locationButton = (Button) findViewById(R.id.buttonGetLocation);
    	locationButton.setOnClickListener(new View.OnClickListener() {

    		@Override
    		public void onClick(View v) {

    			try {
    				locationManager = (LocationManager) getBaseContext().getSystemService(Context.LOCATION_SERVICE);
    				gpsListener = new LocationListener() {
    					public void onLocationChanged(Location location) {
    						if (isBetterLocation(location)) {
    							currentBestLocation = location;
    							TextView txtLatitude = (TextView) findViewById(R.id.textLatitude);
    							TextView txtLongitude = (TextView) findViewById(R.id.textLongitude);
    							TextView txtAccuracy = (TextView) findViewById(R.id.textAccuracy);
    							txtLatitude.setText(String.valueOf(location.getLatitude()));
    							txtLongitude.setText(String.valueOf(location.getLongitude()));
    							txtAccuracy.setText(String.valueOf(location.getAccuracy()));
    						}
    					}

    					public void onStatusChanged(String provider, int status, Bundle extras) {}
    					public void onProviderEnabled(String provider) {}
    					public void onProviderDisabled(String provider) {}
    				};
    				networkListener = new LocationListener() {
    					public void onLocationChanged(Location location) {
    						if (isBetterLocation(location)) {
    							currentBestLocation = location;
    							TextView txtLatitude = (TextView) findViewById(R.id.textLatitude);
    							TextView txtLongitude = (TextView) findViewById(R.id.textLongitude);
    							TextView txtAccuracy = (TextView) findViewById(R.id.textAccuracy);
    							txtLatitude.setText(String.valueOf(location.getLatitude()));
    							txtLongitude.setText(String.valueOf(location.getLongitude()));
    							txtAccuracy.setText(String.valueOf(location.getAccuracy()));
    						}
    					}

    					public void onStatusChanged(String provider, int status, Bundle extras) {}
    					public void onProviderEnabled(String provider) {}
    					public void onProviderDisabled(String provider) {}
    				};

    				locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER,0, 0, gpsListener);
    				locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER,0, 0, networkListener);
    			}
    			catch (Exception e) {		
    				Toast.makeText(getBaseContext(), "Error, Location not available", Toast.LENGTH_LONG).show();                              //4
    			}
    		}

    	});
    }

    @Override
    public void onPause() {
        try {
            locationManager.removeUpdates(gpsListener);
            locationManager.removeUpdates(networkListener);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        super.onPause();
    }

    private boolean isBetterLocation(Location location) {
        boolean isBetter = false;
        if (currentBestLocation == null) { 
        	isBetter = true;
        }
        else if (location.getAccuracy() <= currentBestLocation.getAccuracy()) {
            isBetter = true;
        }
        else if (location.getTime() - currentBestLocation.getTime() > 5*60*1000) {
            isBetter = true;
        }
        return isBetter;
    }

}
