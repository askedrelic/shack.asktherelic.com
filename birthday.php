<?php include "global.php"; ?>

<?php

$username = $_POST['Username'];
$dob = $_POST['Dateofbirth'];

$posted = false;
$exists = false;
if($username != "" && $dob != "") {
    $posted = true;

    $username = trim(strip_tags($username));
    $dob = trim(strip_tags($dob));

    $dbh= mysql_connect('mariadb', 'shack', '824aabd9e5ea4a578ef8ca75e6b4b4496a73a6cbc8ba376ba2d4996d05b2e998') or die ("Woops. Something is broken.");
    mysql_select_db ("shack");

    $query = "SELECT * FROM birthdays where username = '{$username}';";
    $result = mysql_query($query) or die("Woops. Something is broken.");
    $num = mysql_numrows($result);
    if($num > 0) {
        $exists = true;
    }
    else {
        $query = "INSERT INTO `shack`.`birthdays` (`username`, `dob`) VALUES ('{$username}','{$dob}')";
        $result = mysql_query($query) or die("Woops. Something is broken.");
    }
}

?>

<?= getHeader("Shack Birthdays") ?>

<script type="text/javascript">
    $(document).ready(function(){
        $('#datepicker').datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy-mm-dd',
                yearRange: '1900:2015',
                minDate: '-110Y',
                maxDate: '+0D',
                showOn: 'button',
                buttonImage: 'css/calendar.gif',
                buttonImageOnly: true
        });
    });
</script>

<div class="section">
<?php if ($posted === true && $exists === true) { ?>
<p style="color:green;">Congrats, you are already in the database! Why are you entering yourself again?</p>
<?php } else if($posted === true) { ?>
<p style="color:green;">All good, your info has been saved!</p>
<?php } ?>
<form action="" id="birthdayForm" method="post">
<h2>Birthday DB</h2>
<p>This will enter you into the database, if you aren't already in here.</p>
<p>Please use YYYY-MM-DD format for the date or use the calendar icon.</p>
<p>Don't want to reveal your exact birthyear? Just enter 1900 for the year instead, but keep the formatting correct!<p>
<br/>
<p>Username: <input type="text" name="Username" /></p>
<p>DOB: <input type="text" style="margin-left:39px" name="Dateofbirth" id="datepicker" />
</br>
</p>
<p><input type="submit" value="OMGHB2U!!! (Submit)"/></p>
</form>
<br /><br />
<p>If you want to update your birthday or have problems, <a href="http://www.shacknews.com/msgcenter/new_message.x?to=askedrelic">shackmessage me</a>!<p>
<br /><br />
<h3><a href="/">Go Back</a></h3>
</div>

<?= getFooter(false) ?>
