<html>

<head>

<title>View Pharmacy Records</title>

</head>

<body>



<?php

/*

VIEW.PHP

Displays all data from 'pharmacy' table

*/



// connect to the database

include('connect.php');



// get results from database
 
$result = @mysqli_query($dbc, "SELECT * FROM pharmacy");



// display data in table

//echo "<p><b>View All</b> | <a href='view-paginated.php?page=1'>View Paginated</a></p>";


echo "<table border='1' cellpadding='10'>";

echo "<tr> <th>ID</th> <th>Name</th> <th>Town</th> <th>StreetName</th> <th>Number</th> <th>PostalCode</th> <th>PhoneNumber</th> <th></th> <th></th></tr>";



// loop through results of database query, displaying them in the table

while($row = mysqli_fetch_array( $result )) {



// echo out the contents of each row into a table

echo "<tr>";

echo '<td>' . $row['PharmacyId'] . '</td>';

echo '<td>' . $row['Name'] . '</td>';

echo '<td>' . $row['Town'] . '</td>';

echo '<td>' . $row['StreetName'] . '</td>';

echo '<td>' . $row['Number'] . '</td>';

echo '<td>' . $row['PostalCode'] . '</td>';

echo '<td>' . $row['PhoneNumber'] . '</td>';

echo '<td><a href="edit.php?id=' . $row['PharmacyId'] . '">Edit</a></td>';

echo '<td><a href="delete.php?id=' . $row['PharmacyId'] . '">Delete</a></td>';

echo "</tr>";

}



// close table>

echo "</table>";

?>

<p><a href="new.php">Add a new Pharmacy record</a></p>



</body>

</html>