# upload file to api in flutter
## make sure to create folder `/upload` 


# Server code : 

This code allows you to upload an file to the `upload` directory.

```php
<?php

$file_path = "upload/"; //replace it with your folder directory

$file_path = $file_path . basename( $_FILES['file']['name']);
if(move_uploaded_file($_FILES['file']['tmp_name'], $file_path)) {
    echo "success";
} else{
    echo "fail";
}

?>

