#pragma once

#include <mutex>
#include <cassert>
#include "NonCopyable.h"

class SingletonFinalizer : private NonCopyable<SingletonFinalizer>
{
public:
	using FinalizerFunc = void(*)();
	static void AddFinalizer(FinalizerFunc func);
	static void Finalize();
};

template <typename T>
class Singleton : private NonCopyable<Singleton<T>>
{
public:
	static T& GetInstance()
	{
		std::call_once(m_initFlag, Create);
		assert(m_instance);
		return *m_instance;
	}

protected:
	Singleton() {}
	virtual ~Singleton() {}

private:
	static void Create()
	{
		m_instance = new T;
		SingletonFinalizer::AddFinalizer(&Singleton<T>::Destroy);
	}

	static void Destroy()
	{
		delete m_instance;
		m_instance = nullptr;
	}

	static std::once_flag m_initFlag;
	static T* m_instance;
};

template <typename T> std::once_flag Singleton<T>::m_initFlag;
template <typename T> T* Singleton<T>::m_instance = nullptr;