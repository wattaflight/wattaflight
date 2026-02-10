#include <stdatomic.h>

#include "hal/base/sys.h"

static atomic_uint_least32_t ticks;

uint32_t sys_millis(void)
{
    return atomic_load_explicit(&ticks, memory_order_relaxed);
}

void exc_systick(void)
{
    atomic_fetch_add_explicit(&ticks, 1, memory_order_relaxed);
}
