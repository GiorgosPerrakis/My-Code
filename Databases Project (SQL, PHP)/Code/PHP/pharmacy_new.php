<?php

/*

NEW.PHP

Allows user to create a new entry in the database

*/



// creates the new record form

// since this form is used multiple times in this file, I have made it a function that is easily reusable

function renderForm($nm, $twn, $str, $num, $post, $pho, $error)

{

?>

<html>

<head>

<title>New Pharmacy Record</title>

</head>

<body>

<?php

// if there are any errors, display them

if ($error != '')

{

echo '<div style="padding:4px; border:1px solid red; color:red;">'.$error.'</div>';

}

?>



<form action="" method="post">

<div>

<strong>Name: *</strong> <input type="text" name="Name" value="<?php echo $nm; ?>" /><br/>

<strong>Town: *</strong> <input type="text" name="Town" value="<?php echo $twn; ?>" /><br/>

<strong>StreetName: *</strong> <input type="text" name="StreetName" value="<?php echo $str; ?>" /><br/>

<strong>Number: *</strong> <input type="int" name="Number" value="<?php echo $num; ?>" /><br/>

<strong>PostalCode: *</strong> <input type="int" name="PostalCode" value="<?php echo $post; ?>" /><br/>

<strong>PhoneNumber: *</strong> <input type="int" name="PhoneNumber" value="<?php echo $pho; ?>" /><br/>


<p>* required</p>

<input type="submit" name="submit" value="Submit">

</div>

</form>

</body>

</html>

<?php

}









// connect to the database

include('connect.php');



// check if the form has been submitted. If it has, start to process the form and save it to the database

if (isset($_POST['submit']))

{

// get form data, making sure it is valid

$name = mysqli_real_escape_string($dbc, $_POST['Name']);

$town = mysqli_real_escape_string($dbc, $_POST['Town']);

$streetname = mysqli_real_escape_string($dbc, $_POST['StreetName']);

$number = mysqli_real_escape_string($dbc, $_POST['Number']);

$postalcode = mysqli_real_escape_string($dbc, $_POST['PostalCode']);

$phonenumber = mysqli_real_escape_string($dbc, $_POST['PhoneNumber']);


// check to make sure all fields are entered

if ($name == '' || $town == '' || $streetname == '' || $number == '' || $postalcode == '' || $phonenumber == '')

{

// generate error message

	$error = 'ERROR: Please fill in all required fields!';



// if either field is blank, display the form again

renderForm($name, $town, $streetname, $number, $postalcode, $phonenumber, $error);

}

else if(ctype_alpha($name) == false || ctype_alpha($town) == false || ctype_alpha($streetname) == false || ctype_alpha($number) == true || ctype_alpha($postalcode) == true || ctype_alpha($phonenumber) == true)
{
	
	$error = 'ERROR: Please fill in the correct form (no spaces)';
	renderForm($name, $town, $streetname, $number, $postalcode, $phonenumber, $error);
	
}

else if($number < 0 || $number > 1000)
{
	
	$error = 'ERROR: Please fill in real world data';
	renderForm($name, $town, $streetname, $number, $postalcode, $phonenumber, $error);
	
}	

else if($postalcode < 0)
{
	
	$error = 'ERROR: Please fill in real world data';
	renderForm($name, $town, $streetname, $number, $postalcode, $phonenumber, $error);
	
}		

else

{

// save the data to the database

mysqli_query($dbc, "INSERT pharmacy SET Name='$name', Town='$town', StreetName='$streetname', Number='$number', PostalCode='$postalcode', PhoneNumber='$phonenumber'")

or die(mysqli_error());



// once saved, redirect back to the view page

header("Location: view.php");

}

}

else

// if the form hasn't been submitted, display the form

{

renderForm('','','','','','','');

}

?>