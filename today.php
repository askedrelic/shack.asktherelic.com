<?php include "global.php"; ?>

<?= getHeader("Today Is API") ?>

<div class="section">
<h2>Today Is API</h2>
<p>I post a bunch of stats about the current day</p> 
<p>The location of the latest Today Is post: <a href="http://www.shacknews.com/laryn.x?id=<?php echo file_get_contents("./todayis.txt"); ?>"> http://www.shacknews.com/laryn.x?id=<?php echo file_get_contents("./todayis.txt"); ?> </a>
<br /><br />
<p>Today Is is posted every day at 2PM EST, then the location of this txt file is updated with the latest post id: <a href="http://asktherelic.com/shack/todayis.txt">http://asktherelic.com/shack/todayis.txt</a></p>

<br /><br />
<p>Any questions about things, <a href="http://www.shacknews.com/msgcenter/new_message.x?to=askedrelic">shackmessage me</a>!<p>
<br /><br />
<h3><a href="shack.asktherelic.com">Go Back</a></h3>
</div>
<?= getFooter(false) ?>
