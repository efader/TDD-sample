require 'minitest/autorun'
class Point
	def initialize(x,y)
		@x = x.to_f
		@y = y.to_f
	end

	def get_x
		return @x
	end

	def get_y
		return @y
	end

	def to_s
		return "(" + @x.to_s + "," + @y.to_s + ")"
	end

	def distance(a,b)
		return ((a.get_x - b.get_x).abs**2 + (a.get_y - b.get_y).abs**2) ** 0.5
	end		

end

describe Point do 

	it "can be initialized" do
		p = Point.new(1.5,2.6)
		p.must_be_instance_of(Point)
	end

	it "returns x" do
		p = Point.new(-26.1,2.6)
		p.get_x.must_equal(-26.1)
	end

	it "returns y" do
		p = Point.new(1.5,5)
		p.get_y.must_equal(5)
	end
	
	it "has correct distances" do
		p1 = Point.new(1,1)
		p2 = Point.new(2, 1)
		p3 = Point.new(2,6)
		p1.distance(p1,p2).must_equal(1)
		p1.distance(p2,p3).must_equal(5)
		p1.distance(p3,p3).must_equal(0)
		p1.distance(p1,p3).must_be_close_to(5.1)
	end

end

class Rectangle
	def initialize(a, b)
		@point1 = a
		@point2 = Point.new(a.get_x, b.get_y)
		@point3 = b
		@point4 = Point.new(b.get_x, a.get_y)
	end

	def get_points
		return [@point1, @point2, @point3, @point4]
	end

	def area
		return (@point1.get_x - @point3.get_x).abs * (@point1.get_y - @point3.get_y).abs
	end

end

describe Rectangle do

	it "has four points" do
		p1 = Point.new(1.5,2.6)
		p2 = Point.new(3.1, 5.9)
		r = Rectangle.new(p1,p2)
		r.get_points.length.must_equal(4)
		r.get_points[0].must_equal(p1)
		p3 = Point.new(3.1,2.6)
		r.get_points[3].get_x.must_equal(p3.get_x)
		r.get_points[3].get_y.must_equal(p3.get_y)
	end

	it "has correct area" do
		p1 = Point.new(1.5,2.6)
		p2 = Point.new(3.1, 5.9)
		r = Rectangle.new(p1,p2)
		area = 5.28
		r.area.must_be_close_to(area)

	end

end

class Triangle
	def initialize(a, b, c)
		@point1 = a
		@point2 = b
		@point3 = c
	end

	def get_points
		return [@point1, @point2, @point3]
	end

	def area
		side1 = distance(@point1, @point2)
		side2 = distance(@point2, @point3)
		side3 = distance(@point3, @point1)
		s = (side1 + side2 + side3) / 2
		return (s * (s - side1) * (s - side2) * (s - side3))**0.5

	end

	def distance(p1,p2)
		return @point1.distance(p1,p2)
	end

end

describe Triangle do

	it "has three points" do
		p1 = Point.new(1.5,2.6)
		p2 = Point.new(3.1, 5.9)
		p3 = Point.new(8.1,2.6)
		t = Triangle.new(p1,p2,p3)
		t.get_points.length.must_be_close_to(3)
		t.get_points[0].must_equal(p1)
	end


	it "has correct area" do
		p1 = Point.new(1,1)
		p2 = Point.new(2, 1)
		p3 = Point.new(2,6)
		t = Triangle.new(p1,p2,p3)
		area = 2.5
		t.area.must_be_close_to(area)
	end


end

class Circle
	def initialize(p, radius)
		@center = p
		@radius = radius.to_f
	end

	def area
		pi = 3.141592653589793238462643383279
		return pi * @radius ** 2
	end

end

describe Circle do
	it "has correct area" do
		p1 = Point.new(3,3)
		c = Circle.new(p1,3)
		c.area.must_be_close_to(28.2743)
	end
end

class Scene
	def initialize
		@shapes = []
	end

	def is_shape(x)
		return x.class == Triangle || x.class == Rectangle || x.class == Circle
	end

	def add(x)
		if is_shape(x)
			@shapes << [x]
		end
	end

	def remove(x)
		@shapes.delete_if {|y| y==x}

	end

	def shape_count
		return @shapes.length
	end

	def area
		total = 0
		@shapes.each do |shape|
			total = total + shape.area
		end
		return total
	end

end

describe Scene do 
	it "scene properties" do
		p1 = Point.new(3,3)
		c = Circle.new(p1,3)
		p1 = Point.new(1.5,2.6)
		p2 = Point.new(3.1, 5.9)
		p3 = Point.new(8.1,2.6)
		t = Triangle.new(p1,p2,p3)
		s = Scene.new
		s.add(t)
		s.add(c)
		s.shape_count.must_equal(2)
		s.remove(t)
		s.shape_count.must_equal(1)
		s.area.must_be_close_to(30.7743)
	end



end