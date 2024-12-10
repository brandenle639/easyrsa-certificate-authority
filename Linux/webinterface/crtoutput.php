<html>
<body>

<?PHP

$siteuri = $_POST['siteuri'];
$num = escapeshellarg($siteuri);
$command = './scripts/camaker.sh ' . $siteuri;
$output = shell_exec($command);
echo "<pre>$output<pre>";

?>
<iframe src="/zips" id="zips" border="0" width="600" height="500"></iframe>

</body>
</html>
