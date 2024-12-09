#pragma once

// インスタンスコピー防止
template <class T>
class NonCopyable
{
protected:
	NonCopyable() {}
	~NonCopyable() {}

private:
	NonCopyable(const NonCopyable&);
	T& operator=(const T&);
};