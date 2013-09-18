package com.example.helloworld;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class HelloWorldActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hello_world);
        
        initDisplayButton();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
    private void initDisplayButton() {
    	Button displayButton = (Button) findViewById(R.id.buttonDisplay);
    	displayButton.setOnClickListener(new OnClickListener () {

			@Override
			public void onClick(View arg0) {
				EditText editName = (EditText) findViewById(R.id.editTextName);
				TextView textDisplay = (TextView) findViewById(R.id.textViewDisplay);
				String nameToDisplay = editName.getText().toString();
				textDisplay.setText("Hello " + nameToDisplay);
				
			}
    		
    	});
    }
    
}
