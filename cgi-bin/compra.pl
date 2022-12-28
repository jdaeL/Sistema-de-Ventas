#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;
use CGI;
use DBI;
use POSIX;

my $q = CGI->new;
my $preciototal=0;
my $totalobjetos=0;

## obtenemos el nombre
my $name=$q->param('nombre');

## obtenemos la fecha del pedido
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    $year += 1900;
    $mon += 1;
    # Formateamos la fecha y hora utilizando sprintf
    my $fecha_hora = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year, $mon, $mday, $hour, $min, $sec);
    # Imprimimos la fecha y hora
    print "La fecha y hora actuales son: $fecha_hora\n";



# imprimir html 
print "Content-type: text/html\n\n";
print <<HTML; 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Lista del Comprador</title>
    <link rel="icon" type="image/svg" href="../imgs/icon.png"/>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="stylesheet" href="../css/responsive-table.css">

HTML

my $pro1=$q->param('producto1');
my $pro2=$q->param('producto2');
my $pro3=$q->param('producto3');
my $pro4=$q->param('producto4');
my $pro5=$q->param('producto5');
my $pro6=$q->param('producto6');
my $pro7=$q->param('producto7');
my $pro8=$q->param('producto8');
my $pro9=$q->param('producto9');
my $pro10=$q->param('producto10');
my $pro11=$q->param('producto11');
my $pro12=$q->param('producto12');
my $pro13=$q->param('producto13');
my $pro14=$q->param('producto14');
my $pro15=$q->param('producto15');
my $pro16=$q->param('producto16');
my $pro17=$q->param('producto17');
my $pro18=$q->param('producto18');

## Obtenemos el monto 
$preciototal=$pro1*1+$pro2*1.2+$pro3*6.5+$pro4*8+$pro5*4+$pro6*4.2+$pro7*4+$pro8*4+$pro9*4+$pro10*2.2+$pro11*3.8+$pro12*6.5+$pro13*2+$pro14*1+$pro15*1+$pro16*6.5+$pro17+11.5+$pro18*9;
$totalobjetos=$pro1+$pro2+$pro3+$pro4+$pro5+$pro6+$pro7+$pro8+$pro9+$pro10+$pro11+$pro12+$pro13+$pro14+$pro15+$pro16+$pro17+$pro18;

## Codigo
my $code = generar_codigo();

## Conectamos a la base de datos y conectamos los datos
if(defined $name){

    my $nombre = $name;             ## nombre
    my $codigo = $code;             ## generar codigo para la compra
    my $fecha = $fecha_hora;        ## obtenemos fecha
    my $total = $preciototal;      

    my $user = 'root';
    my $password = '71950727joe#';
    my $dsn = "DBI:mysql:database=Tienda;host=localhost";
    my $dbh = DBI ->connect($dsn,$user,$password) or die ("No se pudo conectar");
    my $sth  = $dbh->prepare("INSERT INTO tienda (nombre, codigo, fecha, total) VALUES (?, ?, ?, ?)");

    $sth->excute($nombre, $codigo, $fecha, $total) or die $DBI::errstr;
    
    $sth->finish;
    $dbh->disconnect;

}



## Imprimimos boleta
print <<HTML    
</head>
<body>
    <br><br>
    <h1 style="text-align: center;">Boleta de venta</h1>
    <table>
        <tr>
            <td>Nombre del Producto</td>
            <td>Cantidad</td>
        </tr>
        <tr>
            <td>IDEAL VERDE x 1 UNID</td>
            <td>$pro1</td>
        </tr>
        <tr>
            <td>IDEAL AZUL x 1 UNID</td>
            <td>$pro2</td>
        </tr>
        <tr>
            <td>IDEAL AZUL x 6 UNID</td>
            <td>$pro3</td>
        </tr>
        <tr>
        <tr>
            <td>PARACAS 4 UNID x PQT</td>
            <td>$pro4</td>
        </tr>
        <tr>
            <td>LECHE GLORIA TARRO GRANDE - AZUL</td>
            <td>$pro5</td>
        </tr>
        <tr>
            <td>LECHE GLORIA TARRO GRANDE - CELESTE</td>
            <td>$pro6</td>
        </tr>
        <tr>
            <td>LECHE GLORIATARRO GRANDE - MORADA</td>
            <td>$pro7</td>
        </tr>
        <tr>
            <td>LECHE GLORIA TARRO GRANDE - ROJA</td>
            <td>$pro8</td>
        </tr>
        <tr>
            <td>LECHE GLORIA TARRO GRANDE - AMARILLA</td>
            <td>$pro9</td>
        </tr>
        <tr>
            <td>LECHE GLORIA TARRO PEQUEÑO - AZUL</td>
            <td>$pro10</td>
        </tr>
        <tr>
            <td>LECHE IDEAL GRANDE - CREMOSITA</td>
            <td>$pro11</td>
        </tr>
        <tr>
            <td>YOGURT GLORIA x 1 Kg</td>
            <td>$pro12</td>
        </tr>
        <tr>
            <td>YOGURT GLORIA x 180 gr	</td>
            <td>$pro13</td>
        </tr>
        <tr>
            <td>YOGURT GLORIA x 80 gr</td>
            <td>$pro14</td>
        </tr>
        <tr>
            <td>YOGURT GLORIA GRIEGO x 120 gr</td>
            <td>$pro15</td>
        </tr>
        <tr>
            <td>YOGURT YOFRESH x 970 gr	</td>
            <td>$pro16</td>
        </tr>
        <tr>
            <td>ACEITE VEGETAL PRIMOR 900ml	</td>
            <td>$pro17</td>
        </tr>
        <tr>
            <td>ACEITE DE SOYA SAO 900ml</td>
            <td>$pro18</td>
        </tr>




        <tr>
    </table> 
    <table>
        <td>Precio total    >>>>>    $preciototal</td>
    </table> <br><br>
    <div>
        <h5>Datos de la boleta</h5>
        <h6>Código de venta -> $code</h6>
        <h6>Fecha -> $fecha_hora</h6>
        <h6>Nombre -> $name</h6>
    </div>
    <button style="margin:auto; display:block;" onclick="window.print()">Imprimir boleta</button>
</body>
HTML


## metodo para generar code

# Definimos la función generar_codigo
sub generar_codigo() {
  # Definimos una lista de caracteres que utilizaremos para generar la contraseña
  my @characters = ('a'..'z', 'A'..'Z', 0..9, '!', '@', '#', '$', '%', '^', '&', '*');

  # Generamos una contraseña de 8 caracteres utilizando la función rand y join
  my $code = join '', map { $characters[rand @characters] } 0..7;

  return $code;
}


