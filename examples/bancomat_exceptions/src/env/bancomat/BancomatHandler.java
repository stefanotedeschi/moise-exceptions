package bancomat;

public class BancomatHandler {

	private RequestHandler requestHandler = new RequestHandler();
	private MoneyKeeper moneyKeeper = new MoneyKeeper();

	public void withdraw() {
		try {
			int amount = requestHandler.obtainAmount();
			moneyKeeper.provideMoney(amount);
		} catch (AmountUnavailableException au) {
			System.out.println("Try later.");
		}
	}

}
