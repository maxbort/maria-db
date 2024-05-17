package emaillist;

import java.util.Scanner;

public class EmailListApp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc = new Scanner(System.in);
		
		while(true) {
			System.out.println("(l)ist, (d)elete, (i)nsert, (q)uit > ");
			String command = sc.nextLine();
			
			if("l".equals(command)) {
				doList();
			} else if("d".equals(command)) {
				doDelete();
			}else if("i".equals(command)) {
				doInsert();
			}else if("q".equals(command)) {
				break;
			}
		}
	}
	
	public static void doList() {
		System.out.println("doList");
	}
	public static void doInsert() {	
		System.out.println("doInsert");

	}
	public static void doDelete() {
		System.out.println("doDelete");

	}

}
