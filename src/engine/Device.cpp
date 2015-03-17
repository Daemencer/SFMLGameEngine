#include "engine/Device.hpp"

namespace engine {


Device::Device()
{
	_win = new sf::RenderWindow(sf::VideoMode(800, 600), "Default Window");
}


auto	Device::initialize() -> void
{
	
}


} // namespace engine
