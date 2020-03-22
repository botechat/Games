import pygame as pg
import math

pg.init()
display_width = 700
display_height = 700
gravitational_constant = 20

gameDisplay = pg.display.set_mode((display_width,display_height))
clock = pg.time.Clock()


black = (0,0,0)
white = (255,255,255)
red = (255,0,0)

class Body:

	def __init__(self,posx,posy,velx,vely,mass):
		self.posx = posx
		self.posy = posy
		self.velx = velx
		self.vely = vely
		self.acelx = 0
		self.acely = 0
		self.mass = mass
		self.body_constant = gravitational_constant * self.mass
		self.radius = self.find_radius()

	def find_distance(self,other_body):
		dx = other_body.posx - self.posx
		dy = other_body.posy - self.posy
		d = math.sqrt((dx)**2 + (dy)**2)

		if d < other_body.radius:
			self.kill()

		return dx,dy,d

	def find_acceleration(self,other_body):
		dx, dy, d = self.find_distance(other_body)
		self.acelx = (other_body.body_constant * dx)/d**3
		self.acely = (other_body.body_constant * dy)/d**3

	def find_radius(self):
		radius = (self.mass)
		radius = int(radius)
		return radius

	def display(self):
		pg.draw.circle(gameDisplay,white,(int(self.posx),int(self.posy)),self.radius)

	def move(self):
		self.velx += self.acelx
		self.vely += self.acely
		self.posx += self.velx
		self.posy += self.vely

	def kill(self):
		self.velx = 0
		self.vely = 0
		self.mass = 0
		self.posx = -500
		self.posy = -500


def main():
	gameExit = False

	sun1 = Body(250, (int(display_height/2)),0,0,35)
	sun2 = Body(450, (int(display_height/2)),0,0,35)
	earth = Body(400,0,0,1,1)
	while not gameExit:
		for event in pg.event.get():
			if event.type == pg.QUIT:
				gameExit = True

		
		gameDisplay.fill(black)
		earth.find_acceleration(sun1)
		earth.move()
		earth.find_acceleration(sun2)
		earth.move()
		sun1.find_acceleration(earth)
		sun1.move()
		sun2.find_acceleration(earth)
		sun2.move()

		earth.display()
		sun1.display()
		sun2.display()


		pg.display.update()
		clock.tick(100)

	pg.quit()
	quit()

if __name__ == "__main__":
    main()