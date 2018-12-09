package MooseX::Role::WithOverloading::Meta::Role::Application::Composite::ToRole;

our $VERSION = '0.18';

use Moose::Role;
use namespace::autoclean;

with qw(
    MooseX::Role::WithOverloading::Meta::Role::Application::Composite
    MooseX::Role::WithOverloading::Meta::Role::Application::ToRole
);

1;
__END__

=pod

=cut
