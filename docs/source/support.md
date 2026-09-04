# Request Support

<form action="http://192.168.137.112:5000/submit" method="POST" enctype="multipart/form-data">

<p>
<label>Subject:</label><br>
<input type="text" name="subject" required>
</p>

<p>
<label>Request group:</label><br>
<select name="request_group" required>
<option value="CINECA">CINECA</option>
<option value="ISCRA">ISCRA</option>
<option value="EuroHPC">EuroHPC</option>
<option value="ICEI">ICEI</option>
<option value="PRACE">PRACE</option>
<option value="AGREEMENTS">AGREEMENTS</option>
<option value="INDUSTRIAL">INDUSTRIAL</option>
<option value="PROJECTS">PROJECTS</option>
<option value="EUROfusion">EUROfusion</option>
<option value="EUROfusion-GW">EUROfusion-GW</option>
<option value="Other">Other</option>
</select>
</p>

<p>
<label>Email:</label><br>
<input type="email" name="email" required>
</p>

<p>
<label>Cluster:</label><br>
<select name="cluster" required>
<option value="LEONARDO">LEONARDO</option>
<option value="LEONARDO-DCGP">LEONARDO-DCGP</option>
<option value="GALILEO100">GALILEO100</option>
<option value="PITAGORA-DCGP">PITAGORA-DCGP</option>
<option value="PITAGORA-BOOST">PITAGORA-BOOST</option>
<option value="EFGW">EFGW</option>
<option value="CLOUD_CSL">CLOUD_CSL</option>
<option value="GARDA">GARDA</option>
<option value="MARCONI-SKL">MARCONI-SKL</option>
<option value="PICO">PICO</option>
<option value="Other">Other</option>
</select>
</p>

<p>
<label>Description:</label><br>
<textarea name="description" rows="10" cols="60" required></textarea>
</p>

<p>
<label>Attachment:</label><br>
<input type="file" name="attachment">
</p>

<p>
<button type="submit">Create Ticket</button>
</p>


</form>