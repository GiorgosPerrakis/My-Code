<?php

/*

EDIT.PHP

Allows user to edit specific entry in database

*/



// creates the edit record form

// since this form is used multiple times in this file, I have made it a function that is easily reusable

function renderForm($id, $firstname, $lastname, $speciality, $Experience_Years, $error)

{

?>


<html>

<head>

<title>Edit Doctor Record</title>

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

<input type="hidden" name="Doctor_Id" value="<?php echo $id; ?>"/>

<div>

<p><strong>ID:</strong> <?php echo $id; ?></p>

<strong>First Name: *</strong> <input type="text" name="First_Name" value="<?php echo $firstname; ?>"/><br/>

<strong>Last Name: *</strong> <input type="text" name="Last_Name" value="<?php echo $lastname; ?>"/><br/>

<strong>Speciality: *</strong> <input type="text" name="Speciality" value="<?php echo $speciality; ?>" /><br/>

<strong>Experience Years: *</strong> <input type="int" name="Experience_Years" value="<?php echo $Experience_Years; ?>" /><br/>

<p>* Required</p>

<input type="submit" name="submit" value="Submit">

</div>

</form>

</body>

</html>

<?php

}







// connect to the database

include('connect.php');



// check if the form has been submitted. If it has, process the form and save it to the database

if (isset($_POST['submit']))

{

// confirm that the 'id' value is a valid integer before getting the form data

if (is_numeric($_POST['Doctor_Id']))

{

// get form data, making sure it is valid

$id = $_POST['Doctor_Id'];

$firstname = mysqli_real_escape_string($dbc, $_POST['First_Name']);

$lastname = mysqli_real_escape_string($dbc, $_POST['Last_Name']);

$speciality = mysqli_real_escape_string($dbc, $_POST['Speciality']);

$Experience_Years = mysqli_real_escape_string($dbc, $_POST['Experience_Years']);


// check that firstname/lastname fields are both filled in

if ($firstname == '' || $lastname == '' || $speciality == '' || $Experience_Years == '')

{

// generate error message

$error = 'ERROR: Please fill in all required fields!';



//error, display form

renderForm($id, $firstname, $lastname, $speciality, $Experience_Years, $error);

}

else

{

// save the data to the database

mysqli_query($dbc, "UPDATE doctor SET First_Name='$firstname', Last_Name='$lastname', Speciality='$speciality', Experience_Years='$Experience_Years' WHERE Doctor_Id='$id'")

or die(mysqli_error());



// once saved, redirect back to the view page

header("Location: view.php");

}

}

else

{

// if the 'id' isn't valid, display an error

echo 'Error!';

}

}

else

// if the form hasn't been submitted, get the data from the db and display the form

{



// get the 'id' value from the URL (if it exists), making sure that it is valid (checing that it is numeric/larger than 0)

if (isset($_GET['id']) && is_numeric($_GET['id']) && $_GET['id'] > 0)

{

// query db

$id = $_GET['id'];

$result = mysqli_query($dbc, "SELECT * FROM doctor WHERE Doctor_Id=$id")

or die(mysqli_error());

$row = mysqli_fetch_array($result);



// check that the 'id' matches up with a row in the databse

if($row)

{



// get data from db

$firstname = $row['First_Name'];

$lastname = $row['Last_Name'];

$speciality = $row['Speciality'];

$Experience_Years = $row['Experience_Years'];

// show form

renderForm($id, $firstname, $lastname, $speciality,  $Experience_Years, '');

}

else

// if no match, display result

{

echo "No results!";

}

}

else

// if the 'id' in the URL isn't valid, or if there is no 'id' value, display an error

{

echo 'Error!';

}

}

?>