# Request Support

<form action="http://192.168.137.112:5000/submit" method="POST">

<p>
<label>Subject:</label><br>
<input type="text" name="subject" required>
</p>

<p>
<label>Username:</label><br>
<input type="text" name="username">
</p>

<p>
<label>Email:</label><br>
<input type="email" name="email" required>
</p>

<p>
<label>Cluster:</label><br>
<select name="cluster">
<option value="Leonardo-Booster">Leonardo-Booster</option>
<option value="Leonardo-DCGP">Leonardo-DCGP</option>
<option value="G100">G100</option>
<option value="Pitagora">Pitagora</option>
</select>
</p>

<p>
<label>Description:</label><br>
<textarea name="description" rows="10" cols="60" required></textarea>
</p>

<p>
<button type="submit">Create Ticket</button>
</p>


</form>