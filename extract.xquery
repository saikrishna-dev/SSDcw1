<html>
	<body>
	<table border="2">
		<tr><th>target</th>
			<th>successor</th></tr>
			{
for $w in collection(".?select=*.xml")//w	
           let $str := 'has',
				$normal-lower := normalize-space(lower-case($w)),
				$successor := $w/following-sibling::w[1],
				$next := normalize-space(lower-case($successor))
			where $normal-lower = $str
			return
			<tr>
				<td>	{ $normal-lower } </td>
				<td>	{ $next } </td>
			</tr>
			}
			</table>
		</body>
</html>
