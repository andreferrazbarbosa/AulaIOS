import Foundation

struct Point {
    let x : Double
    let y : Double

    func distance (from point: Point) -> Double {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }

}

struct Triangle {
    enum Kind {
        case equilateral
        case isosceles
        case scalene
    }

    let vertex1 : Point
    let vertex2 : Point
    let vertex3 : Point

    var kind : Kind {
        let dist1_2 = vertex1.distance(from: vertex2).roundTo(places: 2)
        let dist1_3 = vertex1.distance(from: vertex3).roundTo(places: 2)
        let dist2_3 = vertex2.distance(from: vertex3).roundTo(places: 2)

        if dist1_2 == dist1_3 && dist1_2 == dist2_3 {
            return.equilateral
        }
        else if dist1_2 != dist1_3 && dist1_2 != dist2_3 && dist1_3 != dist2_3 {
            return.scalene
        }

        else {
            return.isosceles
        }
    }
}

extension Double {
    func roundTo(places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


var p1 = Point(x: 2,y: 7)
var p2 = Point(x: 2,y: 3)
var p3 = Point(x: 5,y: 3)

var t1 = Triangle(vertex1: p1, vertex2: p2, vertex3: p3)
print(t1.kind)

var p4 = Point(x: 2,y: 3)
var p5 = Point(x: 2,y: 1)
var p6 = Point(x: 4,y: 1)

var t2 = Triangle(vertex1: p4, vertex2: p5, vertex3: p6)
print(t2.kind)

var p7 = Point(x: 5,y: 7)
var p8 = Point(x: 10,y: 9)
var p9 = Point(x: 5.768,y: 12.33)

var t3 = Triangle(vertex1: p7, vertex2: p8, vertex3: p9)
print(t3.kind)
