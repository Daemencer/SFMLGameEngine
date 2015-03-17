#include "engine/Scene.hpp"

namespace engine {


Scene::Scene(const std::string& name)
{
	initialize(name);
}


Scene::~Scene()
{
	shutdown();
}


auto	Scene::initialize(const std::String& name) -> void
{
	if (!_initialized)
	{
		_name = name;

		_root = new Node("Root");
		_root->_scene = this;

		_initialized = true;
	}
}


auto	Scene::shutdown() -> void
{
	if (_initialized)
	{
		delete _root;
		_views.clear();
	}
}


auto	Scene::update() -> void
{
	if (_root->isEnabled()) _root->update();
}


//TODO might need to change the logic for multi scene rendering
auto	Scene::draw() const -> void
{
	if (_initialized)
	{
		for (auto& view : _views)
		{
			if (_root) _root->draw();
		}
	}
}


auto	Scene::findNode(const std::string& name) const -> Node*
{
	if (_initialized)
	{
		if (_root->getName() == name) return _root;
		else
			return _root->findChild(name);
	}
}


// PRIVATE FUNCTIONS

auto	Scene::_bind() -> void
{
	if (_initialized)
	{
		_bound = true;
		_root->_bind();
	}
}


auto	Scene::_unbind() -> void
{
	if (_initialized)
	{
		_bound = false;
		_root->_unbind();
	}
}


} // namespace engine
