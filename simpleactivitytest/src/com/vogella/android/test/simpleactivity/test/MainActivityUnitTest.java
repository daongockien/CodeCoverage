package com.vogella.android.test.simpleactivity.test;

import android.test.ActivityUnitTestCase;


import android.content.Intent;
import android.test.TouchUtils;
import android.test.suitebuilder.annotation.SmallTest;
import android.widget.Button;

import com.vogella.android.test.MainActivity;

public class MainActivityUnitTest extends ActivityUnitTestCase<MainActivity> {
	 private int buttonId;
	  private MainActivity activity;

	  public MainActivityUnitTest() {
	    super(MainActivity.class);
	  }

	  @Override
	  protected void setUp() throws Exception {
	    super.setUp();
	    Intent intent = new Intent(getInstrumentation().getTargetContext(),
	        MainActivity.class);
	    startActivity(intent, null, null);
	    activity = getActivity();
	  }
	  
	  // Check that the layout of the MainActivity contains a button with the R.id.button1 ID
	  //Ensure that the text on the button is "Start"
	  public void testLayout() {
		    buttonId = com.vogella.android.test.R.id.button1;
		    assertNotNull(activity.findViewById(buttonId));
		    Button view = (Button) activity.findViewById(buttonId);
		    //getInstrumentation().callActivityOnStop(activity);
		    //getInstrumentation().callActivityOnStart(activity);
		    assertEquals("Incorrect label of the button", "Start", view.getText());
		  }

	  // Ensure that if the getActivity.onClick() method is called, that the correct intent is triggered via the getStartedActivityIntent() method
	  public void testIntentTriggerViaOnClick() {
	    buttonId = com.vogella.android.test.R.id.button1;
	    Button view = (Button) activity.findViewById(buttonId);
	    assertNotNull("Button not allowed to be null", view);

	    view.performClick();
	    
	    // TouchUtils cannot be used, only allowed in 
	    // InstrumentationTestCase or ActivityInstrumentationTestCase2 
	  
	    // Check the intent which was started
	    Intent triggeredIntent = getStartedActivityIntent();
	    assertNotNull("Intent was null", triggeredIntent);
	    String data = triggeredIntent.getExtras().getString("URL");

	    assertEquals("Incorrect data passed via the intent",
	        "http://www.vogella.com", data);
	  }

}
