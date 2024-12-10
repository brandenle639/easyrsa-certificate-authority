<html>
<head>
  <title>Sharing</title>
  <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
</head>
<body>

<Form name ="form1" Method ="POST" Action ="crtoutput.php" target="myframe">
<label>Site Url to Create: </label>
<INPUT TYPE = "TEXT" Name ="siteuri">
<INPUT TYPE = "Submit" Name = "Submit1" VALUE = "Submit">
</form>
<Form name ="form1" Method ="POST" Action ="rmoutput.php" target="myframe">
<label>Site Url to Remove: </label>
<INPUT TYPE = "TEXT" Name ="siteuri">
<INPUT TYPE = "Submit" Name = "Submit1" VALUE = "Submit">
</form>
</br>
<iframe src="output.php" border="0" name="myframe" width="700" height="800"></iframe>
<iframe src="/zips" border="0" name="myframe" width="700" height="800"></iframe>


</body>
</html>
