public class Woo {

	public static void main(String[] args) {
		Board b = new Board();
		b.generate(70);
		System.out.println(b);
		b.solve();
		System.out.println(b);
	}

}
