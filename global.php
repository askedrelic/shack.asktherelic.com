<?php

function getHeader($title, $extra=NULL) {
$html = '<html>
<head>
<title>AskTheRelic.com | '.$title.'</title>
<style type="text/css">@import "/index.css";</style>
<style type="text/css">@import "/redmond.css";</style>
<script src="http://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("jquery", "1.3.2");
  google.load("jqueryui", "1.7.1");
</script>
';
$html .= "\n".$extra."\n";
$html .= '</head>
<body>
<div id="container">

<div class="section" id="header">
<h1><a href="http://www.asktherelic.com" alt="www.AskTheRelic.com">AskTheRelic.com</a></h1>
</div>';
return $html;
}

function getFooter($google=NULL) {
if($google) {
$html = '</div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-1004202-1";
urchinTracker();
</script>
</body>
</html>';
}
else {
$html = '</div>
</body>
</html>';
}
return $html;
}

?>

