#pragma once

// �C���X�^���X�R�s�[�h�~
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