from azure.servicebus import ServiceBusClient, ServiceBusMessage

# Initialize Service Bus client
connection_string = 'your_connection_string'
queue_name = 'your_queue_name'

servicebus_client = ServiceBusClient.from_connection_string(conn_str=connection_string)

# Function to send a message to the queue
def send_message(message):
    with servicebus_client:
        sender = servicebus_client.get_queue_sender(queue_name=queue_name)
        with sender:
            servicebus_message = ServiceBusMessage(message)
            sender.send_messages(servicebus_message)

# Example usage
if __name__ == '__main__':
    send_message('Hello, Service Bus!')