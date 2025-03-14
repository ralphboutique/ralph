import { Application } from "@hotwired/stimulus";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import ModalController from "./modal_controller";

// Inicializar Stimulus
const application = Application.start();
application.register("modal", ModalController);

// Cargar controladores automáticamente
eagerLoadControllersFrom("controllers", application);
