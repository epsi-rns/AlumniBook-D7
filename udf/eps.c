int modulo(int *, int *);

int modulo(a, b)
     int *a;
     int *b;
{
  if (*b == 0)
    return -1; // return something suitably stupid.
  else
    return *a % *b;
}

/*
# At the command-line

gcc -c -O -fpic -fwritable-strings <your udf>.c
ld -G <your udf>.o -lm -lc -o <your udflib>.so
cp <your udflib>.so /usr/interbase/udf

# In ISQL

declare external function f_Modulo
  integer, integer
  returns
  integer by value
  entry_point 'modulo' module_name 'name of shared library';

commit;

select f_Modulo(3, 2) from rdb$database;

*/
