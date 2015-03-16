TARGET = incredibleMachine

SRC =	main.cpp\
		GameInitializer.cpp\
		engine/Device.cpp\
		engine/ServiceLocator.cpp\
		engine/EventManager.cpp\
		engine/SceneManager.cpp\
		engine/ComponentManager.cpp\
		engine/CollisionManager.cpp\
		engine/AnimationManager.cpp\
		engine/ResourceManager.cpp\
		engine/Debugger.cpp\
		engine/Logger.cpp\
		engine/Scene.cpp\
		engine/Node.cpp\
		engine/Transform.cpp\
		engine/Camera.cpp\
		engine/Component.cpp\
		engine/Animation.cpp\
		engine/TimeLine.cpp\
		engine/Clock.cpp\
		engine/Graphic.cpp\
		engine/RendererPluginLoader.cpp\
		engine/Collider.cpp\
		engine/RenderContext.cpp\
		engine/ColliderFactory.cpp\
		engine/GraphicFactory.cpp\
		engine/ComponentFactory.cpp\
		engine/Manifold.cpp\
		engine/PhysicsEngine.cpp\
		engine/RigidBody.cpp\
		engine/Texture.cpp\
		engine/Font.cpp\
		\
		engine/colliders/RectCollider.cpp\
		engine/colliders/CircleCollider.cpp\
		\
		engine/graphics/CubeGraphic.cpp\
		engine/graphics/SphereGraphic.cpp\
		engine/graphics/RectangleGraphic.cpp\
		engine/graphics/TextGraphic.cpp\
		\
		engine/utils/Utils.cpp\
		engine/utils/Color.cpp\
		engine/utils/json/Json.cpp\
		engine/utils/imgui/imgui.cpp\
		engine/utils/imgui/imsfml.cpp\
		\
		engine/utils/geom/IcoSphere.cpp\
		\
		components/TestComponent.cpp\
		components/BasketController.cpp\
		components/WallController.cpp\
		components/RendererPluginController.cpp\
		components/DebugController.cpp\
		components/BallController.cpp\
		components/PauseController.cpp\
		components/VictoryController.cpp\
		components/PresenceChecker.cpp\
		components/BoxingGloveController.cpp\
		components/NailController.cpp\
		components/Trigger.cpp\
		components/Impulser.cpp\
		components/MoveController.cpp\
		components/Exploder.cpp\
		\
		components/victory/Goal.cpp\
		\
		scenes/SceneV0_1.cpp\

BIN_DIR := ./bin/
OBJ_DIR := ./obj/
SRC_DIR := ./src/
INC_DIR := ./include/ ./include/engine/ ./include/engine/utils/imgui/

SYS_LIBS := sfml-graphics sfml-window sfml-audio sfml-system GL dl
DEP_DIR :=
DEP_LIBS :=
DEP_MAKE := ./plugin/SFMLRenderer/makefile

OBJ := $(patsubst %.cpp,$(OBJ_DIR)%.o,$(SRC))
DEPENDENCIES := $(OBJ:.o=.d)
ARBO := $(sort $(dir $(DEPENDENCIES) $(OBJ_DIR)))

INCLUDES = $(addprefix -I,$(INC_DIR))
CXXFLAGS = -MMD -W -Werror -Wall -std=c++14 $(INCLUDES) -DGLM_FORCE_RADIANS
LDFLAGS = -W -Wall -Werror
LDLIBS = $(addprefix -L,$(DEP_DIR)) $(addprefix -l,$(DEP_LIBS)) $(addprefix -l,$(SYS_LIBS))
CXX = g++
SHELL = /bin/bash

RM_INSTALL_FILES := 

MK_INSTALL_DIR := 

.PHONY: all debug clean fclean re re+ clear run install

debug: CXXFLAGS += -g3
debug: CPPFLAGS += -D__DEBUG__
debug: LDFLAGS += -g3 -D__DEBUG__
debug: build_plugins $(TARGET)

all: CXXFLAGS += -O3 
all: LDFLAGS += -O3
all: $(TARGET)

$(OBJ_DIR)%.o: $(SRC_DIR)%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(ARBO):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

-include $(DEPENDENCIES)

$(TARGET): $(BIN_DIR)$(TARGET) | $(ARBO)

$(BIN_DIR)$(TARGET): $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LDLIBS)

$(OBJ): | $(ARBO)

run: clear debug
	$(BIN_DIR)$(TARGET)

clean:
	$(RM) $(OBJ)
	$(RM) $(DEPENDENCIES)
	$(RM) -r $(ARBO)

fclean: clean
	$(RM) $(TARGET)

re: fclean debug

re+: fclean all
	clear
	$(BIN_DIR)$(TARGET)

release: all

clear:
	clear

build_plugins:
	cd plugin/GLRenderer && $(MAKE)
#	cd plugin/SFMLRenderer && $(MAKE)

download_assets:
	@read -p "Enter Username : " USER;\
	read -s -p "Enter Password : " PASS;\
	echo " ";\
	echo " ";\
	echo Downloading Files ...;\
	echo " ";\
	echo " ";\
	wget -nH --cut-dirs=6 -r --user $$USER --password $$PASS ftp://ftp.isart.fr/GP1/P_CLASSE/2_Travaux/Platformer/BaronBismuthPesenti/BIN/assets;\
	wget -nH --cut-dirs=6 -r --user $$USER --password $$PASS ftp://ftp.isart.fr/GP1/P_CLASSE/2_Travaux/Platformer/BaronBismuthPesenti/BIN/levels.json;


install: download_assets
	@mkdir -p Screenshots;\
	rm -f $(RM_INSTALL_DIR);\
	echo ".";\
	echo ".";\
	echo ".";\
	echo ".";\
	echo Done.


switch:
	touch	src/main.cpp

remi: CPPFLAGS += -DREMI
remi: run

michel: CPPFLAGS += -DMICHEL
michel: run

tom: CPPFLAGS += -DTOM
tom: run

dylan: CPPFLAGS += -DDYLAN
dylan: run

pj: CPPFLAGS += -DPJ
pj: debug
