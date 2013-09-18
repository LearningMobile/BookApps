package com.example.mycontactlist;

import java.io.IOException;
import java.util.List;

import android.app.Activity;
import android.location.Address;
import android.location.Geocoder;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class ContactMapActivity extends Activity {
	
	LocationManager locationManager;
    LocationListener gpsListener;

	
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
				EditText editAddress = (EditText) findViewById(R.id.editAddress);
				EditText editCity = (EditText) findViewById(R.id.editCity);
				EditText editState = (EditText) findViewById(R.id.editState);
				EditText editZipCode = (EditText) findViewById(R.id.editZipcode);
				
				
				String address = editAddress.getText().toString() + ", " +
						editCity.getText().toString() + ", " +
						editState.getText().toString() + " " + 
						editZipCode.getText().toString();

				List<Address> addresses = null;				
				Geocoder geo = new Geocoder(ContactMapActivity.this);
	
				try {
				addresses = geo.getFromLocationName(address, 5);
				} 
				catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
				
				TextView txtLatitude = (TextView) findViewById(R.id.textLatitude);
				TextView txtLongitude = (TextView) findViewById(R.id.textLongitude);
				txtLatitude.setText(String.valueOf(addresses.get(0).getLatitude()));
				txtLongitude.setText(String.valueOf(addresses.get(0).getLongitude()));
			}
    		
    	});
    }

}
