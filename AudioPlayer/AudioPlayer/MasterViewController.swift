//
//  MasterViewController.swift
//  AudioPlayer
//
//  Created by Jose Maria Fernandez on 15/10/16.
//  Copyright © 2016 Universidad de Alicante. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var canciones : Canciones = Canciones()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let cancion1 = Cancion(titulo: "La bicileta", rutaCancion: "la_bicicleta", rutaPortada: "la_bicicleta")
        let cancion2 = Cancion(titulo: "Bailando", rutaCancion: "bailando", rutaPortada: "bailando")
        let cancion3 = Cancion(titulo: "Me equivocaría otra vez", rutaCancion: "me_equivocaria_otra_vez", rutaPortada: "me_equivocaria_otra_vez")
        let cancion4 = Cancion(titulo: "Volare", rutaCancion: "volare", rutaPortada: "volare")
        let cancion5 = Cancion(titulo: "Pont Aeri", rutaCancion: "pont_aeri", rutaPortada: "pont_aeri")
        
        canciones.añadirCancion(cancion: cancion1)
        canciones.añadirCancion(cancion: cancion2)
        canciones.añadirCancion(cancion: cancion3)
        canciones.añadirCancion(cancion: cancion4)
        canciones.añadirCancion(cancion: cancion5)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }*/

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                canciones.cambiarIndice(indice: indexPath.row)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = canciones
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if segue.identifier == "showAleatorio" {
            canciones.cambiarAleatoria()
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = canciones
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canciones.lista.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let cancion = canciones.lista[indexPath.row]
        cell.textLabel!.text = cancion.titulo
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/


}

