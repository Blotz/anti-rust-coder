#include <stdlib.h>

#include "HsFFI.h"

void
example_init (void)
{
  void* p = malloc(1024);
  hs_init (NULL, NULL);
}

void
example_exit (void)
{
  hs_exit ();
}
