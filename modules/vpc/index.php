<?php

$dbhost = 'localhost';
$dbport = '5432';
$dbname = 'postgresqldb';
$charset = 'utf8' ;

$dsn = "pgsql:host={$dbhost};port={$dbport};dbname={$dbname};charset={$charset}";
$username = 'postgres';
$password = 'postgres';

$pdo = new PDO($dsn, $username, $password);

// Make a request to the database
$sql = "SELECT * FROM products";
$stmt = $pdo->prepare($sql);
$stmt->execute();

// Fetch the results
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VPC</title>
</head>
<body>
    <h1>VPC</h1>
    <ul>
        <?php foreach ($products as $product) { ?>
            <li>
                <?php echo $product['name']; ?>
            </li>
        <?php } ?>
    </ul>
</body>
</html>