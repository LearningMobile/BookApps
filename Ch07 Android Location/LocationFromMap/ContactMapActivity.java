package com.example.mycontactlist;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMap.OnMyLocationChangeListener;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.SupportMapFragment;

import android.app.Dialog;
import android.content.DialogInterface;
import android.location.Location;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentActivity;
import android.view.Menu;
import android.widget.Toast;

public class ContactMapActivity extends FragmentActivity {
	
	GoogleMap googleMap;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_contact_map);

		googleMap = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map)).getMap();
		googleMap.setMapType(GoogleMap.MAP_TYPE_NORMAL);

		googleMap.setMyLocationEnabled(true);

		googleMap.setOnMyLocationChangeListener(new OnMyLocationChangeListener() {
			@Override
			public void onMyLocationChange(Location location) {
				LatLng point = new LatLng(location.getLatitude(),location.getLongitude());
				googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(point, 11));
				Toast.makeText(getBaseContext(), "Lat: "+location.getLatitude()+"Long: "+
						location.getLongitude()+" Accuracy:  "+
						location.getAccuracy(), Toast.LENGTH_LONG).show();
			}			
		});              


	}

    
    @Override
    public boolean onCreateOptionsMenu(Menu menu){


    	return true;
    } 

    public void onPause() {
    	   super.onPause();
//    	   finish();
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
}
