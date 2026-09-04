/**
 * Infriqa market demo — new Azure Service Bus / queue dependency (safe to delete).
 * Expected Auto-Heal path:
 *   1) Cloud Impact: queue + infra_change_required (no matching queue on app graph)
 *   2) Create fix PR should patch tofu/ (Service Bus namespace/queue),
 *      NOT invent a fake app worker.
 */
import { ServiceBusClient, ServiceBusReceiver, ServiceBusSender } from "@azure/service-bus";

const ORDERS_QUEUE = "orders";

export type OrderMessage = {
  orderId: string;
  sku: string;
  quantity: number;
};

/**
 * Application now depends on an Azure Service Bus queue for order processing.
 * Infra must exist (namespace + queue + RBAC) before this can run in Azure.
 */
export function createOrdersSender(fullyQualifiedNamespace: string, credential: unknown): ServiceBusSender {
  const client = new ServiceBusClient(fullyQualifiedNamespace, credential as any);
  return client.createSender(ORDERS_QUEUE);
}

export function createOrdersReceiver(fullyQualifiedNamespace: string, credential: unknown): ServiceBusReceiver {
  const client = new ServiceBusClient(fullyQualifiedNamespace, credential as any);
  return client.createReceiver(ORDERS_QUEUE);
}

export async function publishOrder(
  sender: ServiceBusSender,
  order: OrderMessage,
): Promise<void> {
  await sender.sendMessages({
    body: order,
    contentType: "application/json",
    subject: "order.created",
  });
}
