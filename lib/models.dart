import 'package:flutter/material.dart';

class Job {
  final int id;
  final String title;
  final String company;
  final String location;
  final String payment;
  final String schedule;
  final bool urgent;
  final String rating;
  final String description;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.payment,
    required this.schedule,
    required this.urgent,
    required this.rating,
    required this.description,
  });
}

const kJobs = [
  Job(
    id: 1,
    title: 'Ajudante de mudança (Carga/Descarga)',
    company: 'João Logística',
    location: 'Asa Norte, Brasília - DF',
    payment: 'R\$ 150 / dia',
    schedule: 'Hoje, 08h às 17h',
    urgent: true,
    rating: '4,8',
    description:
        'Precisamos de 2 ajudantes fortes para descer móveis de um apartamento (2º andar com elevador). Almoço por nossa conta.',
  ),
  Job(
    id: 2,
    title: 'Atendente para Freelance',
    company: 'Mercado Central',
    location: 'Plano Piloto, Brasília',
    payment: 'R\$ 120 / turno',
    schedule: 'Sábado e domingo',
    urgent: false,
    rating: '4,6',
    description:
        'Atendimento no balcão da padaria do mercado para cobrir folga neste fim de semana. Necessário ser pontual.',
  ),
  Job(
    id: 3,
    title: 'Diarista / Limpeza Pesada',
    company: 'Escritório Alfa',
    location: 'Taguatinga, Brasília - DF',
    payment: 'R\$ 180 / dia',
    schedule: 'Amanhã, período integral',
    urgent: true,
    rating: '5,0',
    description:
        'Limpeza pós-obra de um pequeno escritório comercial de 100m². Fornecemos todos os materiais de limpeza (WAP, produtos, escadas).',
  ),
  Job(
    id: 4,
    title: 'Auxiliar de Cozinha',
    company: 'Restaurante Sabor Mineiro',
    location: 'Lago Sul, Brasília - DF',
    payment: 'R\$ 90 / turno',
    schedule: 'Terça a Sexta, 18h às 23h',
    urgent: false,
    rating: '4,9',
    description:
        'Auxiliar no preparo de guarnições e limpeza da bancada. Ambiente movimentado, exige agilidade.',
  ),
  Job(
    id: 5,
    title: 'Pintor Residencial',
    company: 'Dona Marta',
    location: 'Águas Claras, DF',
    payment: 'R\$ 250 / diária',
    schedule: 'A combinar',
    urgent: false,
    rating: '4,5',
    description:
        'Preciso de um pintor para pintar 2 quartos e 1 sala pequena. O material já foi comprado, pago diária ou fecho pacote.',
  ),
  Job(
    id: 6,
    title: 'Garçom para Evento',
    company: 'Cerimonial Festas',
    location: 'Park Way, DF',
    payment: 'R\$ 150 / evento',
    schedule: 'Sábado, 19h às 02h',
    urgent: true,
    rating: '4,7',
    description:
        'Garçom para casamento para 100 pessoas. Traje: calça preta e sapato social (damos a camisa).',
  ),
  Job(
    id: 7,
    title: 'Panfleteiro(a)',
    company: 'Farmácia Preço Baixo',
    location: 'Ceilândia, DF',
    payment: 'R\$ 70 / meio período',
    schedule: 'Quinta-feira, 08h às 12h',
    urgent: false,
    rating: '4,2',
    description: 'Entrega de panfletos no semáforo principal do bairro.',
  ),
  Job(
    id: 8,
    title: 'Eletricista (Instalação de Ventilador)',
    company: 'Carlos S.',
    location: 'Guará II, DF',
    payment: 'R\$ 100 / serviço',
    schedule: 'Hoje à tarde',
    urgent: true,
    rating: 'Sem avaliação',
    description:
        'Preciso instalar um ventilador de teto novo. Fiação já passada, serviço rápido.',
  ),
];

class ChatConversation {
  final int id;
  final String name;
  final String lastMessage;
  final String time;
  final int unread;

  const ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });
}

const kChats = [
  ChatConversation(
    id: 1,
    name: 'João Logística',
    lastMessage: 'Perfeito, te espero às 8h no endereço.',
    time: '10:42',
    unread: 2,
  ),
  ChatConversation(
    id: 2,
    name: 'Dona Marta',
    lastMessage: 'Você tem os rolos de pintura ou eu compro?',
    time: '09:15',
    unread: 1,
  ),
  ChatConversation(
    id: 3,
    name: 'Mercado Central',
    lastMessage: 'Vaga preenchida, obrigado pelo contato.',
    time: 'Ontem',
    unread: 0,
  ),
  ChatConversation(
    id: 4,
    name: 'Cerimonial Festas',
    lastMessage: 'Mande a foto da sua calça preta, por favor.',
    time: 'Segunda',
    unread: 0,
  ),
  ChatConversation(
    id: 5,
    name: 'Escritório Alfa',
    lastMessage: 'O pagamento é via PIX no fim do dia.',
    time: 'Semana passada',
    unread: 0,
  ),
];
