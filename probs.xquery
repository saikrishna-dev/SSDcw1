<html>
    <body>
    <table border="1">
    <tr>
        <th><i>Target</i></th>
        <th><i>successoressor</i></th>
        <th><i>Probability</i></th>
    </tr>
{   let $successoressorafter := for $s in collection(".?select=*.xml")//s
        return   
            for $w in $s/w
            return
                if(lower-case(normalize-space($w/text())) eq 'has') 
                    then
                        let $successor := (data($s/w[.>> $w][1]))
                        return <tuple> {lower-case(normalize-space($w/text()))} {','}{lower-case(normalize-space($successor))}</tuple>
                    else  ()
    let $corpus := for $s in collection(".?select=*.xml")//s
        return 
            for $w in $s/w
            return <word>{lower-case(normalize-space($w/text()))}</word>
        for $unique in distinct-values($successoressorafter/text())
        let $var := (($successoressorafter[text() = $unique])[1])
        let $arr := tokenize($var, ',')
        let $count := count($successoressorafter[text() = $unique])
        let $total := count($corpus[text()=$arr[2]])
        let $probability := round-half-to-even($count div $total, 2)
       order by $probability descending, $arr[2] ascending
        return
            <tr>
                <td>{$arr[1]}</td>
                <td>{$arr[2]}</td>
                <td>{$probability}</td>
            </tr>
}
    </table>
    </body>
</html>
