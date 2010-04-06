package PNI::GUI;
our $VERSION = '0.0.1';
use strict;
use warnings;
use PNI;
use Tk;
use Tk::Tree;

#PNI
#PNI 4,24
#PNI

#TODO a tendere dovrebbe diventare un modulo PNI::GUI con metodo STARTUP

my $sub = {};
my $get = sub {}; my $set = sub {};
my $NODE = {};
my( $last_x , $last_y , $last_id );
my $mw = PNI::NODE 'Tk::MainWindow';
#my $canvas = PNI::NODE 'Tk::Canvas';
#PNI::LINK $mw => $canvas , 'main_window' => 'window';
my $main_window = $mw->output->{main_window};
# TODO prova a fare la mainwindow invisibile che compare come dialog in caso di chiusura , uguale a vvvv.
$main_window->protocol( 'WM_DELETE_WINDOW' , \&save_xml ); 
my $canvas = $main_window->Canvas();

sub save_xml {
    #questa funzione serve per testare il salvataggio di un file in xml
    #
    print $NODE->{$_} , "\n" for keys %{ $NODE };
    exit;
}

$canvas->configure( 
    -confine => 0 , 
    -height => 400 , 
    -width => 600 , 
    -scrollregion => [ 0 , 0 , 1000 , 1000 ] , 
    -xscrollincrement => 1 , 
    -background => 'white' 
);
$canvas->pack( -expand => 1 , -fill => 'both' );

$sub->{double_click} = sub {
    my $canvas = shift;
    if( $last_id ) {
         my @tags = $canvas->gettags( $last_id );
         
         if( my $node_id = $get->( 'node_id' , of_item => $last_id , in_canvas => $canvas ) ) {
             $sub->{open_inspector}->( $node_id , $canvas );
         }
    }
    else {
        $sub->{open_nodeselector}->( $canvas );
    }
};
$sub->{open_inspector} = sub {
    my( $node_id , $canvas ) = @_;
    my $node_type = ref $NODE->{$node_id}; $node_type =~ s/^PNI::Node:://;
    my $toplevel = $main_window->Toplevel();
    $toplevel->title( $node_type );
    $toplevel->transient( $main_window ); # TODO check portability of transient function.
    my $frame = $toplevel->Frame();
    my @input = sort keys %{ $NODE->{$node_id}->input };
    my @entry = ();
    for( my $i = 0 ; $i <= $#input ; $i++ ) {
        my $input_type = ref $NODE->{$node_id}->input->{$input[$i]} || 'SCALAR';
        my $input_frame = $frame->Frame();
        my $label = $input_frame->Label( -text => $input[$i] . " ($input_type)" );
        my $entry_value;
        if( $input_type eq 'SCALAR' ) {
            $entry_value = $NODE->{$node_id}->input->{$input[$i]};
        }
        elsif( $input_type eq 'ARRAY' ) {
            $entry_value = join ',' , @{ $NODE->{$node_id}->input->{$input[$i]} };
        }
        #elsif( $input_type eq 'HASH' ) {
        #}

        my $entry = $input_frame->Entry( -text => $entry_value );
        $label->pack( -side => 'left' );
        $entry->pack( -side => 'left' , -after => $label );
        $input_frame->pack();
        push @entry , $entry;
    }
    $frame->pack();
    $toplevel->protocol( 'WM_DELETE_WINDOW' , 
        sub { 
            for( my $i = 0 ; $i <= $#input ; $i++ ) {
                my $input_type = ref $NODE->{$node_id}->input->{$input[$i]} || 'SCALAR';
                #$NODE->{$node_id}->input->{$input[$i]} = $entry[$i]->get();
                my $entry_value = $entry[$i]->get();
                if( $input_type eq 'SCALAR' ) {
                    $NODE->{$node_id}->input->{$input[$i]} = $entry_value;
                }
                elsif( $input_type eq 'ARRAY' ) {
                    $NODE->{$node_id}->input->{$input[$i]} = [ split /,/ , $entry_value ];
                }
            }
            $toplevel->destroy(); 
        } 
    ); 
};
#TODO valuta se iniziare a mettere il node_inspector sotto
#PNI::GUI::Node_inspector .. comunque dalla versione > 0.0.1
$sub->{open_nodeselector} = sub { 
    my $canvas = shift;
    my $tree = $canvas->Tree();
    $tree->add( 'Template' , -text => 'Template' , -state => 'normal' );
    $tree->add( 'Perlfunc' , -text => 'Perlfunc' , -state => 'disabled' );
    $tree->add( 'Perlfunc.Print' , -text => 'Print' , -state => 'normal' );
    $tree->add( 'Perlfunc.Cos' , -text => 'Cos' , -state => 'normal' );
    $tree->add( 'Perlfunc.Sin' , -text => 'Sin' , -state => 'normal' );
    $tree->autosetmode();
    my $tk_tree_id = $canvas->createWindow( $canvas->XEvent->x , $canvas->XEvent->y , -window => $tree );
    $tree->configure( -command => [ $sub->{create_node} , $tk_tree_id , $canvas , $canvas->XEvent->x , $canvas->XEvent->y ] );
};
$sub->{create_link} = sub {
    my( $canvas , $tk_output_id ) = @_;

    my $node_id = $get->( 'node_id' , of_item => $tk_output_id , in_canvas => $canvas );
    #my $output_name = ( grep /name=.*/ , @output_tags )[0];
    #$output_name =~ s/^name=(.*)/$1/;

    my @compatible_input_pin_ids = $canvas->find( 'withtag' , "!$node_id&&input" );

    my( $x1 , $y1 , $x2 , $y2 ) = $canvas->coords( $tk_output_id );
    my $output_center_x = ( $x1 + $x2 ) / 2;
    my $output_center_y = ( $y1 + $y2 ) / 2;

    my $link_id = $canvas->createLine( 
        $output_center_x , 
        $output_center_y , 
        $output_center_x , 
        $output_center_y ,
        -arrow => 'none' # 'last'
    );

    $canvas->lower( $link_id , $tk_output_id );
    $canvas->CanvasBind( '<B1-Motion>' => 
        [ $sub->{move_unconnected_link} , $tk_output_id , $link_id , $output_center_x , $output_center_y , @compatible_input_pin_ids ] 
    );
};
$sub->{create_node} = sub {
    my( $tk_tree_id , $canvas , $x, $y , $node_type ) = @_;
    $canvas->delete( $tk_tree_id );
    $node_type =~ s/\./::/;
    my $node = PNI::NODE $node_type;
    $NODE->{$$node} = $node;
    my $width = 6 * length( $node_type );
    my $height = 20;

    my $tk_border_id = $canvas->createRectangle( $x - $width / 2 , $y + $height / 2, $x + $width / 2 , $y - $height / 2 );
    $canvas->addtag( $$node , 'withtag' , $tk_border_id ); # obsoleto
    $set->( node_id => $$node , of_item => $tk_border_id , in_canvas => $canvas );
    $canvas->bind( $tk_border_id , '<B1-Motion>' => [ $sub->{move_node} , $node ] );
    
    my $tk_label_id = $canvas->createText( $x , $y , -text => $node_type );
    $canvas->addtag( $$node , 'withtag' , $tk_label_id ); # obsoleto
    $set->( node_id => $$node , of_item => $tk_label_id , in_canvas => $canvas );
    $canvas->bind( $tk_label_id , '<B1-Motion>' => [ $sub->{move_node} , $node ] );

    my $io_half_width = 3;
    my @input = sort keys %{ $node->input };
    my @output = sort keys %{ $node->output };
    for( my $i = 0 ; $i <= $#input ; $i++ )
    {
        my $num_input_minus_one = $#input || 1;
        my $center_x = $x - $width / 2 + $i * $width / $num_input_minus_one;
        my $center_y = $y - $height / 2;
        my $tk_input_id = $canvas->createRectangle( 
            $center_x - $io_half_width , 
            $center_y + $io_half_width , 
            $center_x + $io_half_width , 
            $center_y - $io_half_width , 
            -fill => 'gray', 
            -activefill => 'black'
        );
        $canvas->addtag( 'input' , 'withtag' , $tk_input_id );
        $canvas->addtag( "$$node" , 'withtag' , $tk_input_id ); # obsoleto
        #$canvas->addtag( "node_id=$$node" , 'withtag' , $tk_input_id );
        $set->( node_id => $$node , of_item => $tk_input_id , in_canvas => $canvas );
        $canvas->addtag( "name=$input[$i]" , 'withtag' , $tk_input_id );
        $canvas->bind( $tk_input_id , '<Enter>' => [ $sub->{show_io_info} , $tk_input_id , $$node ] );
    }
    for( my $i = 0 ; $i <= $#output ; $i++ )
    {
        my $num_output_minus_one = $#output || 1;
        my $center_x = $x - $width / 2 + $i * $width / $num_output_minus_one;
        my $center_y = $y + $height / 2;
        my $tk_output_id = $canvas->createRectangle( 
            $center_x - $io_half_width , 
            $center_y + $io_half_width , 
            $center_x + $io_half_width , 
            $center_y - $io_half_width , 
            -fill => 'gray', 
            -activefill => 'black'
        );
        $canvas->addtag( 'output' , 'withtag' , $tk_output_id );
        $canvas->addtag( "$$node" , 'withtag' , $tk_output_id ); # obsolete
        #$canvas->addtag( "node_id=$$node" , 'withtag' , $tk_output_id );
        $set->( node_id => $$node , of_item => $tk_output_id , in_canvas => $canvas );
        $canvas->addtag( "name=$output[$i]" , 'withtag' , $tk_output_id ); #obsoleto
        $canvas->bind( $tk_output_id , '<ButtonPress-1>' => [ $sub->{create_link} , $tk_output_id ] );
        $canvas->bind( $tk_output_id , '<Enter>' => [ $sub->{show_io_info} , $tk_output_id , $$node ] );
    }
};
$sub->{click_xy} = sub {
    my $canvas = shift;
    $last_x = $canvas->XEvent->x;
    $last_y = $canvas->XEvent->y;
    #warn "$last_x $last_y\n";
    my @current = $canvas->find( 'withtag' , 'current' );
    $last_id = $current[0];
    #for my $current_id ( @current ) {
    #   warn "tags of $current_id : " , join( ' ' , $canvas->gettags( $current_id ) ) , "\n";
    #}
};
$sub->{connect_link} = sub {
    my( $canvas , $tk_output_id , $link_id , $output_center_x , $output_center_y , @compatible_input_pin_ids ) = @_;

    my $tk_input_id = ( $canvas->find( 'closest' , $canvas->XEvent->x , $canvas->XEvent->y ) )[0];
    my @input_tags = $canvas->gettags( $tk_input_id );
    my $io_type = $input_tags[0]; # TODO: prova $item_tag[_COSTANTE_] , aggiungi il controllo sulla distanza ( non deve essere troppo lontano )
    my $is_not_connected = grep( /^connected$/ , @input_tags ) ? 0 : 1;

    if( $io_type eq 'input' and $is_not_connected ) {
        my $target_node_id = ( grep /Node.*/ , @input_tags )[0];
        my $input_name = ( grep /name=.*/ , @input_tags )[0]; $input_name =~ s/^name=(.*)/$1/;

        my @output_tags = $canvas->gettags( $tk_output_id );
        my $source_node_id = ( grep /Node.*/ , @output_tags )[0];
        my $output_name = ( grep /name=.*/ , @output_tags )[0]; $output_name =~ s/^name=(.*)/$1/;

        my( $x1 , $y1 , $x2 , $y2 ) = $canvas->coords( $tk_input_id );
        my $input_center_x = ( $x1 + $x2 ) / 2;
        my $input_center_y = ( $y1 + $y2 ) / 2;
        $canvas->coords( $link_id , $output_center_x , $output_center_y , $input_center_x , $input_center_y );

        $canvas->addtag( "source_node_$source_node_id" , 'withtag' , $link_id );
        $canvas->addtag( "target_node_$target_node_id" , 'withtag' , $link_id );
        $canvas->addtag( "source_output_$output_name"  , 'withtag' , $link_id );
        $canvas->addtag( "target_input_$input_name"    , 'withtag' , $link_id );
        $canvas->addtag( 'connected' , 'withtag' , $tk_input_id );

        # TODO crea prima il link e controlla il valore di ritorno.
        PNI::LINK $NODE->{$source_node_id} => $NODE->{$target_node_id} , $output_name => $input_name;
    }
    else { $canvas->delete( $link_id ); }

    $canvas->CanvasBind( '<ButtonRelease-1>' => undef );
    $canvas->CanvasBind( '<B1-Motion>' => undef );
};
$sub->{show_io_info} = sub {
    my( $canvas , $tk_io_id , $node_id ) = @_;
    my @io_tags = $canvas->gettags( $tk_io_id );
    my $io_type = $io_tags[0]; # obsoleto
    my $io_name = ( grep /name=.*/ , @io_tags )[0]; $io_name =~ s/^name=(.*)/$1/; # obsoleto
    my $io_data;
    my $dy;# = 20; $dy = -20 if $io_type eq 'input';
    if( $io_type eq 'input' ) {
        $dy = -20;
        $io_data = $NODE->{$node_id}->input->{$io_name} || 'EMPTY';
    }
    elsif( $io_type eq 'output' ) {
        $dy = 20;
        $io_data = $NODE->{$node_id}->output->{$io_name} || 'EMPTY';
    }
    my $io_text = $io_name . ' | ' . $io_data;
    my $tk_info_label_id = $canvas->createText( $canvas->XEvent->x , $canvas->XEvent->y + $dy , -text => $io_text );

    $canvas->bind( $tk_io_id , '<Leave>' => sub { shift->delete( $tk_info_label_id ) } );
};
$sub->{move_unconnected_link} = sub {
    my( $canvas , $tk_output_id , $link_id , $output_center_x , $output_center_y , @compatible_input_pin_ids ) = @_;

    $canvas->coords( $link_id , $output_center_x , $output_center_y , $canvas->XEvent->x , $canvas->XEvent->y );

    $canvas->CanvasBind( 
        '<ButtonRelease-1>' => [ $sub->{connect_link} , $tk_output_id , $link_id , $output_center_x , $output_center_y , @compatible_input_pin_ids ] 
    );
};
$sub->{move_node} = sub {
    my( $canvas , $node ) = @_;
    my( $x1 , $y1 , $x2 , $y2 ) = $canvas->coords( $$node );

    my $dx = $canvas->XEvent->x - $last_x;
    my $dy = $canvas->XEvent->y - $last_y;

    return if $x1 + $dx < 1;
    return if $y1 + $dy < 1;

    $canvas->move( $_ , $dx , $dy ) for ( $canvas->find( 'withtag' , $$node ) );
    for ( $canvas->find( 'withtag' ,  "source_node_$$node" ) ) {
        my( $x1 , $y1 , $x2 , $y2 ) = $canvas->coords( $_ );
        $canvas->coords( $_ , $x1 + $dx , $y1 + $dy , $x2 , $y2 ); 
    }
    for ( $canvas->find( 'withtag' ,  "target_node_$$node" ) ) {
        my( $x1 , $y1 , $x2 , $y2 ) = $canvas->coords( $_ );
        $canvas->coords( $_ , $x1 , $y1 , $x2 + $dx , $y2 + $dy ); 
    }

    $last_x = $canvas->XEvent->x;
    $last_y = $canvas->XEvent->y;
};
$get = sub {
    my $attribute = shift;
    my $tk_canvas_id = { @_ }->{of_item};
    my $canvas = { @_ }->{in_canvas};

    my @tags = $canvas->gettags( $tk_canvas_id );
    my $value = ( grep /^$attribute=.*/ , @tags )[0] or return;
    $value =~ s/^$attribute=//;
    #warn "item $tk_canvas_id: get $attribute = $value\n";
    return $value
};
$set = sub {
    my $attribute = shift;
    my $value = shift;
    my $tk_canvas_id = { @_ }->{of_item};
    my $canvas = { @_ }->{in_canvas};

    $canvas->addtag( "$attribute=$value" , 'withtag' , $tk_canvas_id );
    #warn "item $tk_canvas_id: set $attribute = $value\n";
};

$canvas->CanvasBind( '<Double-Button-1>' => [ $sub->{double_click} ] );
$canvas->CanvasBind( '<ButtonPress-1>' => [ $sub->{click_xy} ] );

PNI::LOOP;

__END__


