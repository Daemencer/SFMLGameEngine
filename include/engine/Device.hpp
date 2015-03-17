#ifndef __DEVICE_HPP_INCLUDED__
#define __DEVICE_HPP_INCLUDED__

#include <SFML/Window.hpp>

namespace engine {


class Device final
{
public:
	Device();
	Device(const Device&) = default;
	auto	operator = (const Device&) -> Device& = default;
	~Device() = default;

	auto	initialize() -> void;

	auto	run() -> void;

	auto	shutdown() -> void;

	auto	getWindow() const -> sf::RenderWindow { return _win; }

private:
	sf::RenderWindow*	_win;

	bool				_running = true;

};


} // namespace engine

#endif /* __DEVICE_HPP_INCLUDED__ */
