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
	Scene(const Scene&);
	auto	operator = (const Scene&) -> Scene& = delete;
	virtual ~Scene();

	auto	initialize(const std::string&) -> void;
	auto	shutdown() -> void;

	auto	update() -> void;
	auto	draw() const -> void;

	auto	setName(const std::string& name) -> void { _name = name; }
	auto	getName() const -> const std::string& { return _name; }

	auto	setLayer(unsigned int level) -> void { _layer = level; }
	auto	getLayer() const -> unsigned int { return _layer; }

	auto	setEnabled(bool value) -> void { _enabled = value; }
	auto	isEnabled() const -> bool { return _enabled; }
	auto	isBound() const -> bool { return _bound; }

	auto	getRoot() const -> Node* { return _root; }

	auto	findNode(const std::string&) const -> Node*;

	auto	getViews() const -> std::vector<sf::View*> { return _views; }

	auto	isEnabled() const -> void { return _enabled; }
	auto	setEnabled(bool enabled) -> void { _enabled = enabled; }

	auto	addView(sf::View*) -> void;
	auto	removeView(sf::View*) -> void;

private:
	auto	_bind() -> void;
	auto	_unbind() -> void;

	std::string		_name = "Default Scene";
	bool			_enabled = true;
	bool			_initialized = false;
	bool			_bound = false;
	Node*			_root;

	unsigned int	_layer = 0;

	std::vector<sf::View*>	_views;

};


} // namespace engine

#endif /* __SCENE_HPP_INCLUDED__ */
