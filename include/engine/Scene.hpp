#ifndef __SCENE_HPP_INCLUDED__
#define __SCENE_HPP_INCLUDED__

#include <string>
#include <vector>

namespace engine {


class Scene
{
public:
	Scene() = default;
	Scene(const std::string&);
	Scene(const Scene&) = default;
	auto	operator = (const Scene&) -> Scene& = default;
	~Scene() = default;

	auto	getName() const -> const std::string& { return _name; }

	auto	getViews() const -> std::vector<sf::View*> { return _views; }

	auto	isEnabled() const -> void { return _enabled; }
	auto	setEnabled(bool enabled) -> void { _enabled = enabled; }

	auto	addView(sf::View*) -> void;
	auto	removeView(sf::View*) -> void;

private:
	std::string				_name;

	bool					_enabled = true;

	std::vector<sf::View*>	_views;

};


} // namespace engine

#endif /* __SCENE_HPP_INCLUDED__ */
