#include "stdafx.h"
#include "Singleton.h"

static const int MAX_FINALIZERS_SIZE = 256;
static int g_numFinalizersSize = 0;
static SingletonFinalizer::FinalizerFunc g_finalizers[MAX_FINALIZERS_SIZE];

void SingletonFinalizer::AddFinalizer(FinalizerFunc func)
{
	assert(g_numFinalizersSize < MAX_FINALIZERS_SIZE);
	g_finalizers[g_numFinalizersSize++] = func;
}

void SingletonFinalizer::Finalize()
{
	for (int i = g_numFinalizersSize - 1; i >= 0; --i)
	{
		(*g_finalizers[i])();
	}
	g_numFinalizersSize = 0;
}