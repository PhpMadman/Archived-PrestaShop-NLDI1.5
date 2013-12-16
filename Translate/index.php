<html>
<head>
	<title>Translate</title>
	<meta content="charset=utf-8" http-equiv="Content-Type">
</head>
<body>
<?php
	$module = "validatecustomer";
	$tplfile = "validate";
	$string = "If you want an instant answer, please call";
	$translate = "Om du vill ha svart direkt, ring";
	$hash = md5($string);
	echo('$_MODULE[\'<{' . $module . '}prestashop>' . $tplfile . '_' . $hash . '\'] = \'' . $translate . '\';');
?>
</body>
</html>